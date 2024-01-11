import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Text('User not logged in');
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return Text('User not found');
        }

        var userData = snapshot.data!.data()
            as Map<String, dynamic>; // Cast to Map<String, dynamic>
        // Access the user data fields and display them in your profile widget
        // For example:
        String username = userData['username'];
        String email = userData['email'];

        return Column(
          children: [
            Text('Username: $username'),
            Text('Email: $email'),
            // Add more widgets to display other user data fields
          ],
        );
      },
    );
  }
}
