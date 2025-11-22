import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/pagination.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  
  List<Product> _products = [];
  Product? _selectedProduct;
  Pagination? _pagination;
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  Pagination? get pagination => _pagination;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch products
  Future<void> fetchProducts({int page = 1, int limit = 20}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _productService.getProducts(page: page, limit: limit);
      _products = result['products'];
      _pagination = result['pagination'];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch product by ID
  Future<void> fetchProductById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedProduct = await _productService.getProductById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load more products (pagination)
  Future<void> loadMoreProducts() async {
    if (_pagination == null || _isLoading) return;
    
    final nextPage = _pagination!.currentPage + 1;
    if (nextPage > _pagination!.totalPage) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _productService.getProducts(
        page: nextPage,
        limit: _pagination!.limit,
      );
      
      _products.addAll(result['products']);
      _pagination = result['pagination'];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear selected product
  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
