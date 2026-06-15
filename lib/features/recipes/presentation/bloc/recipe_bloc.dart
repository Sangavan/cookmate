import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipes _getRecipes;

  RecipeBloc(this._getRecipes) : super(RecipeInitial()) {
    on<LoadRecipes>(_onLoadRecipes);
    on<RefreshRecipes>(_onRefreshRecipes);
  }

  Future<void> _onLoadRecipes(
    LoadRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipeLoading());

    final result = await _getRecipes(
      search: event.search,
      category: event.category,
    );

    result.fold(
      (failure) => emit(RecipeError(failure.message)),
      (recipes) => emit(RecipeLoaded(recipes)),
    );
  }

  Future<void> _onRefreshRecipes(
    RefreshRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    final result = await _getRecipes();

    result.fold(
      (failure) => emit(RecipeError(failure.message)),
      (recipes) => emit(RecipeLoaded(recipes)),
    );
  }
}