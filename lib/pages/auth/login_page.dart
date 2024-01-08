import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';

import '../../utils/theme.utils.dart';
import '../../widgets/headline.widget.dart';
import 'forgetPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeUtils.themeData,
      debugShowCheckedModeBanner: false,
      builder: (_, b) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AppAuthProvider>(
              builder: (ctx, appAuthProvider, _) {
                return Form(
                  key: appAuthProvider.formKey,
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeadlineWidget(
                            title: 'Log In',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: appAuthProvider.emailController,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'email is required';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'Enter Valid Email';
                              } else {
                                if (!value.split('@').last.contains('gmail')) {
                                  return 'Enter Valid Gmail';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              suffixIcon: const Icon(Icons.mail),
                              fillColor: Colors.white,
                              isDense: true,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: appAuthProvider.obscureText,
                            controller: appAuthProvider.passwordController,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'password is required';
                              }
                              if (value.length < 8) {
                                return 'Password length must be 8';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              suffixIcon: InkWell(
                                onTap: () {
                                  appAuthProvider.toggleObscure();
                                },
                                child: appAuthProvider.obscureText
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              fillColor: Colors.white,
                              isDense: true,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () =>
                                  appAuthProvider.openSignupPage(context),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text: 'Don\'t Have Account ?',
                                      children: [
                                        TextSpan(
                                            text: ' Create New',
                                            style: TextStyle(color: Colors.red))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await appAuthProvider.login(context);
                              },
                              style: ElevatedButton.styleFrom(
                                // fillColor: Colors.red,
                                shape: StadiumBorder(),
                                elevation: 10,
                                backgroundColor: Colors.redAccent,
                                shadowColor: Colors.red,
                                fixedSize: Size(350, 50),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " SIGN IN",
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
                                  ])),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Forget_Password())),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(250, 50),
                            ),
                            child: const Text('Forget Password'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
