import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'token_storage.dart';

class DioClient {
  late final Dio dio;
  final TokenStorage _tokenStorage;

  DioClient(this._tokenStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(_authInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  /// Interceptor that:
  /// 1. Attaches the access token to every request.
  /// 2. On a 401 (expired token), tries to refresh and retries the request.
  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Skip auth header for login/register/refresh
        final isAuthEndpoint = options.path.contains('/auth/');
        if (!isAuthEndpoint) {
          final token = await _tokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // If access token expired (401), try refreshing once.
        if (error.response?.statusCode == 401) {
          final refreshed = await _tryRefreshToken();
          if (refreshed) {
            // Retry the original request with the new token.
            final newToken = await _tokenStorage.getAccessToken();
            final options = error.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            try {
              final response = await dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              return handler.next(error);
            }
          }
        }
        handler.next(error);
      },
    );
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) return false;

      // Use a clean Dio instance so we don't loop through interceptors.
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      final response = await refreshDio.post(
        ApiConstants.refresh,
        data: {'refresh': refreshToken},
      );

      final newAccess = response.data['access'] as String;
      await _tokenStorage.saveTokens(
        access: newAccess,
        refresh: refreshToken, // refresh token stays the same
      );
      return true;
    } catch (e) {
      // Refresh failed — token fully expired, user must log in again.
      await _tokenStorage.clearTokens();
      return false;
    }
  }
}