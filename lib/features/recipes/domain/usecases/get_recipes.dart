import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipes {
  final RecipeRepository _repository;

  GetRecipes(this._repository);

  Future<Either<Failure, List<Recipe>>> call({
    String? search,
    String? category,
  }) {
    return _repository.getRecipes(search: search, category: category);
  }
}