import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/recipes/presentation/pages/recipe_list_page.dart';

void main() async {
  // Ensure Flutter is ready before we do async setup.
  WidgetsFlutterBinding.ensureInitialized();

  // Wire up all dependencies before the app starts.
  await setupDependencies();

  runApp(const CookMateApp());
}

class CookMateApp extends StatelessWidget {
  const CookMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
       home: const RecipeListPage(),
    );
  }
}