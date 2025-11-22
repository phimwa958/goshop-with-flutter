import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'api_config.dart';
import '../config/api_config.dart';


class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final _storage = FlutterSecureStorage();
  String? _accessToken;

  // Get access token
  Future<String?> getAccessToken() async {
    _accessToken ??= await _storage.read(key: 'access_token');
    return _accessToken;
  }

  // Set access token
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    await _storage.write(key: 'access_token', value: token);
  }

  // Clear access token
  Future<void> clearAccessToken() async {
    _accessToken = null;
    await _storage.delete(key: 'access_token');
  }

  // Get common headers
  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (includeAuth) {
      final token = await getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // GET request
  Future<http.Response> get(String endpoint, {bool requiresAuth = false}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders(includeAuth: requiresAuth);

    try {
      final response = await http
          .get(url, headers: headers)
          .timeout(ApiConfig.timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // POST request
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = false,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders(includeAuth: requiresAuth);

    try {
      final response = await http
          .post(url, headers: headers, body: jsonEncode(body))
          .timeout(ApiConfig.timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // PUT request
  Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = false,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders(includeAuth: requiresAuth);

    try {
      final response = await http
          .put(url, headers: headers, body: jsonEncode(body))
          .timeout(ApiConfig.timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // DELETE request
  Future<http.Response> delete(String endpoint, {bool requiresAuth = false}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _getHeaders(includeAuth: requiresAuth);

    try {
      final response = await http
          .delete(url, headers: headers)
          .timeout(ApiConfig.timeout);
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Handle API response
  dynamic handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      final json = jsonDecode(response.body);
      return json['result'];
    } else {
      final json = jsonDecode(response.body);
      final error = json['error'];
      if (error is Map<String, dynamic>) {
        throw Exception(error['message'] ?? 'API Error: ${response.statusCode}');
      }
      throw Exception('API Error: ${response.statusCode}');
    }
  }
}
