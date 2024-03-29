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
  // late TabController _controller;
  //int selectIndex = 0;
  /*with SingleTickerProviderStateMixin*/
  StreamSubscription<User?>? _listener;
  @override
  void initState() {
    //  _controller = TabController(length: 3, vsync: this);
    checkUser();
    super.initState();
  }

  // _controller.addListener((){
//etState((){
//selectedindex =_controller.index;
//}
  //});

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 30));
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
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 25, color: Colors.red),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black),
            indicator: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            tabs: [
              Tab(text: 'Log In'),
              Tab(text: 'Sign Up'),
              Tab(text: 'Forget Password')
            ],
          ),
        ),
        body: TabBarView(
          //  controller: _controller,

          children: [LoginPage(), SignupPage(), Forget_Password()],
        ),
      ),
    );
  }
}
