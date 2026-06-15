import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipes({String? search, String? category});
  Future<RecipeDetailModel> getRecipeDetail(int id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final DioClient _dioClient;

  RecipeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<RecipeModel>> getRecipes({String? search, String? category}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (category != null && category.isNotEmpty) queryParams['category'] = category;

      final response = await _dioClient.dio.get(
        ApiConstants.recipes,
        queryParameters: queryParams,
      );

      final data = response.data as List<dynamic>;
      return data
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_dioErrorMessage(e));
    }
  }

  @override
  Future<RecipeDetailModel> getRecipeDetail(int id) async {
    try {
      final response = await _dioClient.dio.get('${ApiConstants.recipes}$id/');
      return RecipeDetailModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(_dioErrorMessage(e));
    }
  }

  String _dioErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. The server may be waking up — please try again.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection.';
    }
    return 'Something went wrong (${e.response?.statusCode ?? 'unknown'}).';
  }
}