import 'dart:convert';
import '../models/user.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiService.post(
      ApiConfig.login,
      {
        'email': email,
        'password': password,
      },
    );

    final data = _apiService.handleResponse(response);
    
    // Save access token
    if (data['access_token'] != null) {
      await _apiService.setAccessToken(data['access_token']);
    }

    if (data['user'] == null) {
      throw Exception('Login failed: No user data returned');
    }

    return {
      'user': User.fromJson(data['user']),
      'access_token': data['access_token'],
      'refresh_token': data['refresh_token'],
    };
  }

  // Register
  Future<User> register(String email, String password) async {
    final response = await _apiService.post(
      ApiConfig.register,
      {
        'email': email,
        'password': password,
      },
    );

    final data = _apiService.handleResponse(response);
    
    if (data['user'] == null) {
      throw Exception('Registration failed: No user data returned');
    }
    
    return User.fromJson(data['user']);
  }

  // Get current user profile
  Future<User> getMe() async {
    final response = await _apiService.get(
      ApiConfig.me,
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    return User.fromJson(data);
  }

  // Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    final response = await _apiService.put(
      ApiConfig.changePassword,
      {
        'password': currentPassword,
        'new_password': newPassword,
      },
      requiresAuth: true,
    );

    _apiService.handleResponse(response);
  }

  // Logout
  Future<void> logout() async {
    await _apiService.clearAccessToken();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _apiService.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
