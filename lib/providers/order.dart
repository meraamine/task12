import 'package:shopify_app/models/product.model.dart';

class Order {
  final String id;
  final List<Product> products;
  final int quantity;
  final String userId;
  final DateTime timestamp;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.userId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product?.toJson()).toList(),
      'quantity': quantity,
      'userId': userId,
      'timestamp': timestamp.toString(),
    };
  }
}
