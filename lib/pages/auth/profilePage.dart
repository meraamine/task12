import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify_app/models/user.model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService _authService = AuthService();
  User? _user;
  String? _name;
  String? _phone;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final User? user = await _authService.getCurrentUser();
    if (user != null) {
      final User updatedUser = await _authService.getUserDetails(user);
      final userData = await _authService.getUserData(user.uid);
      setState(() {
        _user = updatedUser;
        _name = userData['name'];
        _phone = userData['phone'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile'),
      ),
      body: _user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Name: ${_name ?? 'N/A'}'),
                ),
                ListTile(
                  title: Text('Email: ${_user!.email ?? 'N/A'}'),
                ),
                ListTile(
                  title: Text('Phone: ${_phone ?? 'N/A'}'),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }*/

  /*Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }*/

  Future<User?> getCurrentUser() async {
    final User? user = _auth.currentUser;
    return user;
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<User> getUserDetails(User user) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(user.uid).get();
    final userData = snapshot.data() as Map<String, dynamic>;

    UserProfile customUser = UserProfile(
      name: userData['name'] as String?,
      phone: userData['phone'] as String?,
      email: userData['email'] as String?,
    );

    return user;
  }
}
