import 'package:flutter/material.dart';
import 'package:shopify_app/pages/home_page.dart';
import 'package:shopify_app/widgets/headline.widget.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({super.key});

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          HeadlineWidget(title: "Forget Password"),
          const SizedBox(
            height: 20,
          ),
          Text(
              "Enter the email address you used to create your account and we will email you a link to reset your password"),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Send Email'),
              suffixIcon: const Icon(Icons.mail),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(300, 60),
            ),
            child: Text(
              'Send Email  ',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      )),
    ));
  }
}
