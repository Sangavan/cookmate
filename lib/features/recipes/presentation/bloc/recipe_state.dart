part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

/// Before anything loads.
class RecipeInitial extends RecipeState {}

/// Loading in progress (show spinner).
class RecipeLoading extends RecipeState {}

/// Recipes loaded successfully (show the list).
class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;

  const RecipeLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

/// Something went wrong (show error + retry).
class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object?> get props => [message];
}