import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/pages/splash_page.dart';
import 'package:shopify_app/widgets/headline.widget.dart';
import '../../providers/app_auth.provider.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({Key? key}) : super(key: key);

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text(" Forget Password "),
          leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SplashPage()));
        },
        icon: Icon(Icons.arrow_back),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AppAuthProvider>(
          builder: (BuildContext context, AppAuthProvider appAuthProvider,
              Widget? child) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopify-92b0f.appspot.com/o/products%2F3333.jpg?alt=media&token=48dc2074-ea16-46d3-8965-e42b947f3df4"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //HeadlineWidget(title: "Forgot Password"),
                    Text(
                      "Forgot Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff515C6F),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Enter the email address you used to create your account, and we will email you a link to reset your password.",
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: const Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        elevation: 10,
                        backgroundColor: Colors.redAccent,
                        shadowColor: Colors.red,
                        fixedSize: const Size(350, 50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SEND EMAIL",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                        ],
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password reset email sent. Check your inbox.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }
}
