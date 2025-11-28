import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  late Dio _dio;
  final String baseUrl;
  final Connectivity _connectivity = Connectivity();

  ApiService({this.baseUrl = 'http://localhost:3000'}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token if available
          final token = await _getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle network errors and retry
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            try {
              // checkConnectivity returns ConnectivityResult (single value in v5.0.2)
              final ConnectivityResult connectivityResult = await _connectivity
                  .checkConnectivity();
              // Check if there's no connection
              if (connectivityResult == ConnectivityResult.none) {
                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    error: 'No internet connection',
                  ),
                );
              }
            } catch (e) {
              // If connectivity check fails, continue with original error
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    // This will be implemented by the auth service
    return null;
  }

  void setToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final responseData = error.response?.data;
        if (responseData is Map) {
          final message =
              responseData['message'] ??
              responseData['error'] ??
              'An error occurred';
          return Exception(message.toString());
        }
        return Exception('An error occurred');
      } else {
        // Network error - provide more helpful messages
        if (error.type == DioExceptionType.connectionTimeout) {
          return Exception(
            'Connection timeout. Please check if the server is running.',
          );
        } else if (error.type == DioExceptionType.receiveTimeout) {
          return Exception('Request timeout. Please try again.');
        } else if (error.type == DioExceptionType.connectionError) {
          return Exception(
            'Cannot connect to server. Please check:\n1. Server is running on port 3000\n2. Correct API URL (10.0.2.2 for emulator, your IP for physical device)',
          );
        }
        return Exception(
          error.message ?? 'Network error. Please check your connection.',
        );
      }
    }
    return Exception('An unexpected error occurred: ${error.toString()}');
  }
}
