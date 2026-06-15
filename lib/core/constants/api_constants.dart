class ApiConstants {
  ApiConstants._(); // private constructor — constants-only class

  // Your live Render backend
  static const String baseUrl = 'https://cookmate-backend-hrse.onrender.com/api';

  // Auth endpoints
  static const String register = '/auth/register/';
  static const String login = '/auth/login/';
  static const String refresh = '/auth/refresh/';

  // Recipe endpoints
  static const String recipes = '/recipes/';
  static const String favorites = '/favorites/';

  // Timeouts (Render free tier sleeps — generous to allow wake-up)
  static const Duration connectTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
}