import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  static const String baseUrl = 'https://barateknologi.com/actitrack/api/v1';
  
  late final Dio _dio;
  final Logger _logger = Logger();
  
  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ));
    
    // Add logging interceptor for debugging
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _logger.i('📤 REQUEST: ${options.method} ${options.path}');
        _logger.i('📦 DATA: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        _logger.i('📥 RESPONSE: ${response.statusCode}');
        _logger.i('📦 DATA: ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) {
        _logger.e('❌ ERROR: ${error.message}');
        return handler.next(error);
      },
    ));
  }
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login.php',
        data: {
          'email': email.trim().toLowerCase(),
          'password': password,
        },
      );
      
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return Map<String, dynamic>.from(e.response!.data);
      }
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan. Silakan coba lagi.',
      };
    }
  }
  
  Future<Map<String, dynamic>> getMe() async {
    try {
      final response = await _dio.get('/auth/me.php');
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return Map<String, dynamic>.from(e.response!.data);
      }
      return {
        'success': false,
        'message': 'Session expired. Please login again.',
      };
    }
  }
  
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _dio.post('/auth/logout.php');
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      return {
        'success': true,
        'message': 'Logout successful',
      };
    }
  }
}