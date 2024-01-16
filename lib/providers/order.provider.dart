import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify_app/models/cart.model.dart';

class OrderProvider {
  CollectionReference ordersRef =
      FirebaseFirestore.instance.collection('orders');

  Future<void> placeOrder(Cart cart) async {
    try {
      // Create a new order document
      DocumentReference orderDocRef = await ordersRef.add({
        'timestamp': DateTime.now(),
        'items': cart.items?.map((item) => item.toJson()).toList(),
      });

      // Print the order ID for reference
      print('Order placed. Order ID: ${orderDocRef.id}');
    } catch (e) {
      print('Failed to place order: $e');
    }
  }
}
