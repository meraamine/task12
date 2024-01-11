import 'package:flutter/material.dart';
import 'package:shopify_app/models/user.model.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: UserProfile(),
    );
  }
}
