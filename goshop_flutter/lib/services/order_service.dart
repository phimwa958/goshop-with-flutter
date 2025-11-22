import '../models/order.dart';
import '../models/pagination.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class OrderService {
  final ApiService _apiService = ApiService();

  // Get list of orders
  Future<Map<String, dynamic>> getOrders({
    String? code,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    var endpoint = '${ApiConfig.orders}?page=$page&limit=$limit';
    if (code != null) endpoint += '&code=$code';
    if (status != null) endpoint += '&status=$status';

    final response = await _apiService.get(
      endpoint,
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    
    final orders = (data['orders'] as List<dynamic>?)
        ?.map((json) => Order.fromJson(json as Map<String, dynamic>))
        .toList() ?? [];
    
    final pagination = data['pagination'] != null
        ? Pagination.fromJson(data['pagination'] as Map<String, dynamic>)
        : Pagination.empty();

    return {
      'orders': orders,
      'pagination': pagination,
    };
  }

  // Get order by ID
  Future<Order> getOrderById(String id) async {
    final response = await _apiService.get(
      ApiConfig.orderById(id),
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    return Order.fromJson(data);
  }

  // Place order
  Future<Order> placeOrder({
    required String userId,
    required List<Map<String, dynamic>> lines,
  }) async {
    final response = await _apiService.post(
      ApiConfig.orders,
      {
        'user_id': userId,
        'lines': lines,
      },
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    return Order.fromJson(data);
  }

  // Cancel order
  Future<void> cancelOrder(String id) async {
    final response = await _apiService.put(
      ApiConfig.cancelOrder(id),
      {},
      requiresAuth: true,
    );

    _apiService.handleResponse(response);
  }
}
