import '../models/product.dart';
import '../models/pagination.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // Get list of products
  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 20,
    String? name,
    String? code,
    String? orderBy,
    bool? orderDesc,
  }) async {
    var endpoint = '${ApiConfig.products}?page=$page&limit=$limit';
    if (name != null) endpoint += '&name=$name';
    if (code != null) endpoint += '&code=$code';
    if (orderBy != null) endpoint += '&order_by=$orderBy';
    if (orderDesc != null) endpoint += '&order_desc=$orderDesc';

    final response = await _apiService.get(endpoint);

    final data = _apiService.handleResponse(response);
    
    final products = (data['products'] as List<dynamic>?)
        ?.map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList() ?? [];
    
    final pagination = data['pagination'] != null
        ? Pagination.fromJson(data['pagination'] as Map<String, dynamic>)
        : Pagination.empty();

    return {
      'products': products,
      'pagination': pagination,
    };
  }

  // Get product by ID
  Future<Product> getProductById(String id) async {
    final response = await _apiService.get(
      ApiConfig.productById(id),
    );

    final data = _apiService.handleResponse(response);
    return Product.fromJson(data);
  }

  // Create product (requires authentication)
  Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
  }) async {
    final response = await _apiService.post(
      ApiConfig.products,
      {
        'name': name,
        'description': description,
        'price': price,
      },
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    return Product.fromJson(data);
  }

  // Update product (requires authentication)
  Future<Product> updateProduct({
    required String id,
    String? name,
    String? description,
    double? price,
  }) async {
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (description != null) body['description'] = description;
    if (price != null) body['price'] = price;

    final response = await _apiService.put(
      ApiConfig.productById(id),
      body,
      requiresAuth: true,
    );

    final data = _apiService.handleResponse(response);
    return Product.fromJson(data);
  }
}
