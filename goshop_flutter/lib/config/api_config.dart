import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  // Base URL for the GoShop API
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8888/api/v1';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8888/api/v1';
    }
    return 'http://localhost:8888/api/v1';
  }
  
  // API timeout duration
  static const Duration timeout = Duration(seconds: 30);
  
  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';
  static const String refreshToken = '/auth/refresh';
  
  static const String products = '/products';
  static String productById(String id) => '/products/$id';
  
  static const String orders = '/orders';
  static String orderById(String id) => '/orders/$id';
  static String cancelOrder(String id) => '/orders/$id/cancel';
}
