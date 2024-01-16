import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Order> orders = _convertToOrders(snapshot.data!.docs);

          return OrderList(orders: orders);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<Order> _convertToOrders(List<QueryDocumentSnapshot> docs) {
    return docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Order.fromJson(data);
    }).toList();
  }
}

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];
        return ListTile(
          title: Text('Order ID: ${order.id}'),
          subtitle: Text('Time: ${order.createdAt.toString()}'),
          // Display other order details as needed
        );
      },
    );
  }
}

class Order {
  String? id;
  DateTime? createdAt;

  Order({required this.id, required this.createdAt});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: json['createdAt'] != null
          ? json['createdAt'].toDate()
          : DateTime.now(),
    );
  }
}
