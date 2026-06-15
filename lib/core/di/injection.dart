import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/token_storage.dart';

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
}