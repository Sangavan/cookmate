import 'package:equatable/equatable.dart';

/// A recipe in its pure form (no JSON, no API details).
class Recipe extends Equatable {
  final int id;
  final String name;
  final String category;
  final String area;
  final String thumbnail;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, name, category, area, thumbnail];
}

/// Full recipe detail, including ingredients and steps.
class RecipeDetail extends Equatable {
  final int id;
  final String name;
  final String category;
  final String area;
  final String thumbnail;
  final String youtubeUrl;
  final String tags;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  const RecipeDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnail,
    required this.youtubeUrl,
    required this.tags,
    required this.ingredients,
    required this.steps,
  });

  @override
  List<Object?> get props => [id, name, ingredients, steps];
}

class Ingredient extends Equatable {
  final String name;
  final String measure;

  const Ingredient({required this.name, required this.measure});

  @override
  List<Object?> get props => [name, measure];
}

class RecipeStep extends Equatable {
  final int order;
  final String instruction;

  const RecipeStep({required this.order, required this.instruction});

  @override
  List<Object?> get props => [order, instruction];
}