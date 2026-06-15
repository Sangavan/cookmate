part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

/// Load the recipe list (optionally with search/category).
class LoadRecipes extends RecipeEvent {
  final String? search;
  final String? category;

  const LoadRecipes({this.search, this.category});

  @override
  List<Object?> get props => [search, category];
}

/// User pulled to refresh.
class RefreshRecipes extends RecipeEvent {
  const RefreshRecipes();
}