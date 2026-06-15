import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeDetail {
  final RecipeRepository _repository;

  GetRecipeDetail(this._repository);

  Future<Either<Failure, RecipeDetail>> call(int id) {
    return _repository.getRecipeDetail(id);
  }
}