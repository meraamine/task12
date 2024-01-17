import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/models/user.model.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/pages/home_page.dart';
import 'package:shopify_app/pages/master_page.dart';
import 'package:shopify_app/pages/splash_page.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';

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
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SplashPage()));
              },
              icon:
                  Icon(Icons.arrow_back, color: Color(0xffff6969), size: 18))),
      body: _user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIhsJ2D692LXEDT04mefdqZtznqnIg31FnmX5-aETP1O-rA40rRhSYbMrmMTfTVHHwoCk&usqp=CAU")),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.white),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: Text(
                      'Name: ${_name ?? 'N/A'}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono'),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Email: ${_user!.email ?? 'N/A'}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Phone: ${_phone ?? 'N/A'}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () =>
                          Provider.of<AppAuthProvider>(context, listen: false)
                              .onLogout(context),
                      style: ElevatedButton.styleFrom(
                        // fillColor: Colors.red,
                        shape: StadiumBorder(),
                        elevation: 10,
                        backgroundColor: Colors.redAccent,
                        shadowColor: Colors.red,
                        fixedSize: Size(250, 50),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " LOG OUT",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Spacer(),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.red,
                                size: 24.0,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
