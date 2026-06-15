import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recipe.dart';

/// The contract: what recipe operations the app can do.
/// The domain defines WHAT; the data layer decides HOW.
abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipes({
    String? search,
    String? category,
  });

  Future<Either<Failure, RecipeDetail>> getRecipeDetail(int id);
}