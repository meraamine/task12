import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify_app/pages/order_details_page.dart';

class MyOrdersPage extends StatelessWidget {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  Future<void> createOrder(String orderNumber, String status) async {
    try {
      await ordersCollection.add({
        'orderNumber': orderNumber,
        'status': status,
      });
      print('Order created successfully');
    } catch (e) {
      print('Error creating order: $e');
    }
  }

  Stream<QuerySnapshot> getOrderStream() {
    try {
      return ordersCollection.snapshots();
    } catch (e) {
      print('Error getting order stream: $e');
      return Stream<QuerySnapshot>.empty();
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await ordersCollection.doc(orderId).delete();
      print('Order deleted successfully');
    } catch (e) {
      print('Error deleting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrderStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching orders'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final orders = snapshot.data?.docs ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Text('No orders found'),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              final orderNumber = order.get('orderNumber') as String? ?? 'N/A';
              final status = order.get('status') as String? ?? 'N/A';

              return ListTile(
                title: Text(orderNumber),
                subtitle: Text(status),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(
                        orderNumber: orderNumber,
                        status: status,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteOrder(orderId),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createOrder('New Order', 'Pending');
        },
      ),
    );
  }
}
