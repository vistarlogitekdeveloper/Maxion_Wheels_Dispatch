import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';

class ApiClient {
  late final Dio dio;
  String? _cachedToken;

  ApiClient() {
    const rootUrl = ApiEndpoints.baseUrl;
    final formattedBase = rootUrl.endsWith('/') ? rootUrl : '$rootUrl/';

    dio = Dio(
      BaseOptions(
        baseUrl: formattedBase,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _initToken();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!options.path.startsWith('http://') && !options.path.startsWith('https://')) {
            var p = options.path;
            while (p.startsWith('/')) {
              p = p.substring(1);
            }
            options.path = '$formattedBase$p';
          }
          if (_cachedToken != null && _cachedToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_cachedToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _initToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _cachedToken = prefs.getString('auth_token');
    } catch (_) {}
  }

  void updateToken(String? token) {
    _cachedToken = token;
  }
}
