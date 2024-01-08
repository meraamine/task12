import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/pages/master_page.dart';
import 'package:shopify_app/services/push_notification.service.dart';
import 'auth/forgetPassword.dart';
import 'auth/signup.page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription<User?>? _listener;
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 100));
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      } else {
        PushNotificationService.checkNotificationOnKilledApp();
        PushNotificationService.init();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MasterPage()));
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Log In'),
              Tab(text: 'Sign Up'),
              Tab(text: 'Forget Password')
            ],
          ),
        ),
        body: TabBarView(
          children: [LoginPage(), SignupPage(), Forget_Password()],
        ),
      ),
    );
  }
}
