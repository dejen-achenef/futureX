import 'package:dio/dio.dart';

/// Helper class to test API connection
class ApiHelper {
  static Future<bool> testConnection(String baseUrl) async {
    try {
      final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ));

      final response = await dio.get('/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static String getConnectionErrorMessage(String baseUrl) {
    if (baseUrl.contains('10.0.2.2')) {
      return 'Cannot connect to server.\n\nFor Android Emulator:\n- Make sure server is running on port 3000\n- Try: http://10.0.2.2:3000';
    } else if (baseUrl.contains('localhost')) {
      return 'Cannot connect to server.\n\nFor iOS Simulator:\n- Make sure server is running on port 3000\n- Try: http://localhost:3000';
    } else {
      return 'Cannot connect to server.\n\nPlease check:\n1. Server is running\n2. Correct IP address\n3. Firewall settings';
    }
  }
}

