// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';

import '../../widgets/headline.widget.dart';
import '../splash_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(" Sign Up  "),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SplashPage()) );
            },
            icon: Icon(Icons.arrow_back),
          )),
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
                        HeadlineWidget(title: 'Sign Up',),
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
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await appAuthProvider.signUp(context);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " SIGN UP",
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
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => appAuthProvider
                                .openTermsAndCondtionSPage(context),
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text:
                                          'By creating an account, you agree to our  ',
                                      children: [
                                        TextSpan(
                                            text: ' \n Terms Of Service ',
                                            style:
                                                TextStyle(color: Colors.red)),
                                        TextSpan(
                                            text: ' and ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                            text: ' Privacy Policy ',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }
}
