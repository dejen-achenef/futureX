import '../models/user_model.dart';
import '../../core/network/api_service.dart';
import '../../core/storage/secure_storage_service.dart';

class AuthRepository {
  final ApiService _apiService;
  final SecureStorageService _storage;

  AuthRepository(this._apiService, this._storage);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      // Check if response is successful
      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? 'Login failed');
      }

      final data = response.data['data'];
      if (data == null) {
        throw Exception('Invalid response from server');
      }

      final token = data['token'] as String?;
      final userData = data['user'] as Map<String, dynamic>?;

      if (token == null || userData == null) {
        throw Exception('Missing token or user data in response');
      }

      final user = UserModel.fromJson(userData);

      // Save token securely
      await _storage.saveToken(token);
      await _storage.saveUserId(user.id);
      _apiService.setToken(token);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      // Extract error message from exception
      String errorMessage = 'Login failed';
      if (e.toString().contains('Exception:')) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = e.toString();
      }
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await _apiService.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      // Check if response is successful
      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }

      final data = response.data['data'];
      if (data == null) {
        throw Exception('Invalid response from server');
      }

      final token = data['token'] as String?;
      final userData = data['user'] as Map<String, dynamic>?;

      if (token == null || userData == null) {
        throw Exception('Missing token or user data in response');
      }

      final user = UserModel.fromJson(userData);

      // Save token securely
      await _storage.saveToken(token);
      await _storage.saveUserId(user.id);
      _apiService.setToken(token);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      // Extract error message from exception
      String errorMessage = 'Registration failed';
      if (e.toString().contains('Exception:')) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = e.toString();
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
    _apiService.setToken(null);
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.getToken();
    if (token != null) {
      _apiService.setToken(token);
      return true;
    }
    return false;
  }
}

