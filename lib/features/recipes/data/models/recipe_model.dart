import '../../domain/entities/recipe.dart';

/// Recipe model — knows how to parse JSON from the API.
class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.thumbnail,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      area: json['area'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }
}

class IngredientModel extends Ingredient {
  const IngredientModel({required super.name, required super.measure});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'] as String? ?? '',
      measure: json['measure'] as String? ?? '',
    );
  }
}

class RecipeStepModel extends RecipeStep {
  const RecipeStepModel({required super.order, required super.instruction});

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) {
    return RecipeStepModel(
      order: json['order'] as int? ?? 0,
      instruction: json['instruction'] as String? ?? '',
    );
  }
}

class RecipeDetailModel extends RecipeDetail {
  const RecipeDetailModel({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.thumbnail,
    required super.youtubeUrl,
    required super.tags,
    required super.ingredients,
    required super.steps,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      area: json['area'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      youtubeUrl: json['youtube_url'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
      ingredients: (json['ingredients'] as List<dynamic>? ?? [])
          .map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>? ?? [])
          .map((e) => RecipeStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}