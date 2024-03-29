import 'package:flutter/material.dart';
import 'package:shopify_app/pages/master_page.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MasterPage()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffff6969),
            size: 18,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            child: ListTile(
              tileColor: Colors.white,
              title: Text(notification),
              subtitle: Text('Notification details...'),
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              onTap: () {
                // Handle tapping on a notification
                print('Tapped on notification: $notification');
              },
            ),
          );
        },
      ),
    );
  }
}


/*class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}*/

/*class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> campaigns = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Handling a foreground message: ${message.messageId}");
      displayCampaign(message);
    });
  }

  void displayCampaign(RemoteMessage message) {
    final data = message.data;
    if (data.isNotEmpty) {
      setState(() {
        campaigns.add(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaignData = campaigns[index];
          return ListTile(
            title: Text(campaignData['title'] ?? ''),
            subtitle: Text(campaignData['description'] ?? ''),
          );
        },
      ),
    );
  }
}*/

