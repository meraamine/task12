import 'package:flutter/material.dart';
import 'package:shopify_app/services/messagingServiceFirebase.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() async {
    // await _firebaseMessagingService.configureFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}
