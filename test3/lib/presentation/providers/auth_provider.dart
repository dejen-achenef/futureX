import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/network/api_service.dart';
import '../../core/storage/secure_storage_service.dart';

String _getApiBaseUrl() {
  // Use production API URL
  const String productionUrl = 'https://futurex-5.onrender.com';
  
  // For web builds, use production URL
  if (kIsWeb) {
    return productionUrl;
  }
  
  // For Android emulator - use production URL (or localhost for local dev)
  if (Platform.isAndroid) {
    // Uncomment for local development:
    // return 'http://10.0.2.2:3000';
    return productionUrl;
  }
  
  // For iOS simulator - use production URL (or localhost for local dev)
  if (Platform.isIOS) {
    // Uncomment for local development:
    // return 'http://localhost:3000';
    return productionUrl;
  }
  
  // Default fallback to production
  return productionUrl;
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: _getApiBaseUrl());
});

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(apiServiceProvider),
    ref.read(secureStorageProvider),
  );
});

class AuthState {
  final UserModel? user;
  final String? token;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.token,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null && token != null;

  AuthState copyWith({
    UserModel? user,
    String? token,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    state = state.copyWith(isLoading: true);
    try {
      final isAuth = await _authRepository.isAuthenticated();
      if (isAuth) {
        // Token exists, but we'd need to fetch user data
        // For now, just set authenticated state
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.login(email, password);
      state = state.copyWith(
        user: result['user'] as UserModel,
        token: result['token'] as String,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.register(name, email, password);
      state = state.copyWith(
        user: result['user'] as UserModel,
        token: result['token'] as String,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

