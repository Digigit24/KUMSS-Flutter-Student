import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  late Dio _dio;
  late Logger _logger;
  final _secureStorage = const FlutterSecureStorage();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _logger = Logger();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Config.apiBaseUrl,
        connectTimeout: const Duration(milliseconds: Config.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: Config.receiveTimeout),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authorization token if available
          final token = await _secureStorage.read(key: 'access_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Add college ID header
          if (Config.collegeId.isNotEmpty) {
            options.headers['X-College-ID'] = Config.collegeId;
          }

          _logger.i('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('Response: ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          _logger.e('Error: ${e.message}');

          // Handle 401 Unauthorized - try token refresh
          if (e.response?.statusCode == 401) {
            _logger.i('Token expired, attempting refresh...');
            // TODO: Implement token refresh logic
            // For now, redirect to login
          }

          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<void> setAuthToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }

  Future<void> logout() async {
    await clearAuthToken();
    _dio.options.headers['Authorization'] = '';
  }
}
