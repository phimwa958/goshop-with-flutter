import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/pagination.dart';
import '../services/order_service.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();
  
  List<Order> _orders = [];
  Order? _selectedOrder;
  Pagination? _pagination;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Shopping cart
  final List<CartItem> _cartItems = [];

  List<Order> get orders => _orders;
  Order? get selectedOrder => _selectedOrder;
  Pagination? get pagination => _pagination;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<CartItem> get cartItems => _cartItems;
  int get cartItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Fetch orders
  Future<void> fetchOrders({
    String? code,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _orderService.getOrders(
        code: code,
        status: status,
        page: page,
        limit: limit,
      );
      _orders = result['orders'];
      _pagination = result['pagination'];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch order by ID
  Future<void> fetchOrderById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedOrder = await _orderService.getOrderById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Place order
  Future<bool> placeOrder(String userId) async {
    if (_cartItems.isEmpty) {
      _errorMessage = 'Cart is empty';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final lines = _cartItems.map((item) => {
        'product_id': item.product.id,
        'quantity': item.quantity,
      }).toList();

      final order = await _orderService.placeOrder(
        userId: userId,
        lines: lines,
      );
      
      _selectedOrder = order;
      _cartItems.clear();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cancel order
  Future<bool> cancelOrder(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _orderService.cancelOrder(id);
      
      // Update order status in the list
      final index = _orders.indexWhere((order) => order.id == id);
      if (index != -1) {
        // Refresh the order to get updated status
        await fetchOrderById(id);
        if (_selectedOrder != null) {
          _orders[index] = _selectedOrder!;
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Add to cart
  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Update cart item quantity
  void updateCartItemQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Clear selected order
  void clearSelectedOrder() {
    _selectedOrder = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
