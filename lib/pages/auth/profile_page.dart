import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../models/user.model.dart';

// Get the authenticated user's ID
////String userId = FirebaseAuth.instance.currentUser.uid;

// Retrieve the user data from Firestore
//DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//  .collection('users')
//.doc(userId)
//  .get();

// Access the user's data
//String name = userSnapshot['name'];
//String email = userSnapshot['email'];

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('users').doc(currentUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            UserProfile user = UserProfile(
              id: currentUser.uid,
              email: currentUser.email!,
              profilePictureUrl: userData['profilePictureUrl'] ?? '',
              name: '',
            );
            return buildProfilePage(user as User);
          }
          return Text('No user data found');
        },
      );
    } else {
      // Handle the case when there is no authenticated user
      return Text('User not signed in');
    }
  }

  Widget buildProfilePage(User user) {
    // Build your profile page UI using the retrieved user data
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Text('ID: ${user.uid}'),
          Text('Email: ${user.email}'),
          ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  withData: true,
                  type: FileType.image,
                );
                var refrence = FirebaseStorage.instance
                    .ref('products/${result?.files.first.name}');

                if (result?.files.first.bytes != null) {
                  var uploadResult = await refrence.putData(
                      result!.files.first.bytes!,
                      SettableMetadata(contentType: 'image/png'));

                  if (uploadResult.state == TaskState.success) {
                    print('>>>>>>>>>>>>>>>>${await refrence.getDownloadURL()}');
                  }
                }
              },
              child: Text('upload image'))
          // Add more user data fields or UI components as needed
        ],
      ),
    );
  }
}
