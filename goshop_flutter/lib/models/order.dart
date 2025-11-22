class OrderProduct {
  final String id;
  final String code;
  final String name;
  final double price;

  OrderProduct({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'price': price,
    };
  }
}

class OrderLine {
  final OrderProduct product;
  final int quantity;
  final double price;

  OrderLine({
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    return OrderLine(
      product: OrderProduct.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'price': price,
    };
  }
}

class Order {
  final String id;
  final String code;
  final String status;
  final double totalPrice;
  final List<OrderLine> lines;

  Order({
    required this.id,
    required this.code,
    required this.status,
    required this.totalPrice,
    required this.lines,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      code: json['code'] as String,
      status: json['status'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      lines: (json['lines'] as List<dynamic>?)
          ?.map((line) => OrderLine.fromJson(line as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'status': status,
      'total_price': totalPrice,
      'lines': lines.map((line) => line.toJson()).toList(),
    };
  }
}
