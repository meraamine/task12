import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            child: Sidebar(),
          ),
          Expanded(
            child: Center(
              child: Text('Content goes here'),
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Technology'),
          onTap: () {
            // Handle technology category selection
          },
        ),
        ListTile(
          title: Text('Home and Garden'),
          onTap: () {
            // Handle home and garden category selection
          },
        ),
        ListTile(
          title: Text('Fashion and Beauty'),
          onTap: () {
            // Handle fashion and beauty category selection
          },
        ),
        ListTile(
          title: Text('Sports and Fitness'),
          onTap: () {
            // Handle sports and fitness category selection
          },
        ),
        ListTile(
          title: Text('Books and Entertainment'),
          onTap: () {
            // Handle books and entertainment category selection
          },
        ),
      ],
    );
  }
}
