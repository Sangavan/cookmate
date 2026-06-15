import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/token_storage.dart';

import '../../features/recipes/data/datasources/recipe_remote_datasource.dart';
import '../../features/recipes/data/repositories/recipe_repository_impl.dart';
import '../../features/recipes/domain/repositories/recipe_repository.dart';
import '../../features/recipes/domain/usecases/get_recipes.dart';
import '../../features/recipes/domain/usecases/get_recipe_detail.dart';
import '../../features/recipes/presentation/bloc/recipe_bloc.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Registers all app dependencies. Called once at startup in main().
Future<void> setupDependencies() async {
  // ── External / third-party ──
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);

  // ── Core services ──
  getIt.registerSingleton<TokenStorage>(
    TokenStorage(getIt<FlutterSecureStorage>()),
  );

  getIt.registerSingleton<DioClient>(
    DioClient(getIt<TokenStorage>()),
  );

  // Feature dependencies (auth, recipes) will be registered here
  // as we build them in the next steps.
  // ── Recipes feature ──
  // Data source
  getIt.registerSingleton<RecipeRemoteDataSource>(
    RecipeRemoteDataSourceImpl(getIt<DioClient>()),
  );

  // Repository
  getIt.registerSingleton<RecipeRepository>(
    RecipeRepositoryImpl(getIt<RecipeRemoteDataSource>()),
  );

  // Use cases
  getIt.registerSingleton<GetRecipes>(
    GetRecipes(getIt<RecipeRepository>()),
  );
  getIt.registerSingleton<GetRecipeDetail>(
    GetRecipeDetail(getIt<RecipeRepository>()),
  );

  // Bloc — registered as factory (new instance each time it's needed)
  getIt.registerFactory<RecipeBloc>(
    () => RecipeBloc(getIt<GetRecipes>()),
  );



}