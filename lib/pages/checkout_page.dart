import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String fullName = '';
  String address = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              onChanged: (value) {
                setState(() {
                  fullName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Place Order'),
              onPressed: () {
                // Logic to handle placing the order
                // You can implement your own logic here
                print('Order placed!');
                print('Full Name: $fullName');
                print('Address: $address');
                print('Phone Number: $phoneNumber');
              },
            ),
          ],
        ),
      ),
    );
  }
}
