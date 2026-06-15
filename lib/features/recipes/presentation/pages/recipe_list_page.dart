import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/recipe_bloc.dart';
import '../widgets/recipe_card.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecipeBloc>()..add(const LoadRecipes()),
      child: const RecipeListView(),
    );
  }
}

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CookMate 🍳'),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading || state is RecipeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RecipeError) {
            return _ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<RecipeBloc>().add(const LoadRecipes()),
            );
          }

          if (state is RecipeLoaded) {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No recipes found.'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RecipeBloc>().add(const RefreshRecipes());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    onTap: () {
                      // Recipe detail navigation — coming in next step
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped: ${recipe.name}')),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}