import 'package:flutter/material.dart';

import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> cartItems = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double sum = 0.0;
    // Calculate the total amount based on the cart items
    // You can replace the logic below with your own logic
    for (int i = 0; i < cartItems.length; i++) {
      sum += 10.0; // Assuming each item costs $10
    }
    setState(() {
      totalAmount = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Checkout'),
              onPressed: () {
                // Logic to handle the checkout process
                // You can implement your own logic here

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()));
                print('Checkout initiated!');
                print('Total Amount: $totalAmount');
                // Additional checkout logic goes here
              },
            ),
          ),
        ],
      ),
    );
  }
}
