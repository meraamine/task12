import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/pages/auth/signup.page.dart';
import 'package:shopify_app/pages/master_page.dart';
import 'dart:io';
import '../pages/auth/terms_policy_page.dart';
import '../pages/splash_page.dart';
import 'package:image_picker/image_picker.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  TextEditingController? phoneController;

  bool obscureText = true;

  void init() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    formKey = null;
  }

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);
        var credintials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController?.text ?? '',
                password: passwordController?.text ?? '');
        if (context.mounted) {
          Navigator.pop(context);
          if (credintials.user != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MasterPage()));
            providerDispose();
          } else {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error In Sign up');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        if (e.code == 'user-not-found') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'user not found');
        } else if (e.code == 'wrong-password') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'wrong password');
        } else {
          await QuickAlert.show(
              context: context, type: QuickAlertType.error, title: e.code);
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Login Error ${e}');
      }
    }
  }

  /*Future<void> signUp(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

        var credintials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController?.text ?? '',
            password: passwordController?.text ?? '');

        if (context.mounted) {
          Navigator.pop(context);
          if (credintials.user != null) {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'You Signup Successfully');


            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MasterPage()));
              providerDispose();
            }
          } else {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error In Signup');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'This Email Already in use');
        } else if (e.code == 'weak-password') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Weak Password');
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Signup Error ${e}');
      }
    }
  }*/

  /*Future<void> signUp(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

        var credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController?.text ?? '',
          password: passwordController?.text ?? '',
        );

        if (context.mounted) {
          Navigator.pop(context);
          if (credentials.user != null) {
            // Upload profile picture to Firebase Storage
            FilePickerResult? result =
            await FilePicker.platform.pickFiles(
              withData: true,
              type: FileType.image,
            );
            var refrence = FirebaseStorage.instance
                .ref('products/${result?.files.first.name}');

           /* if (result?.files.first.bytes != null) {
              var uploadResult = await refrence.putData(
                  result!.files.first.bytes!,
                  SettableMetadata(contentType: 'image/png'));

              if (uploadResult.state == TaskState.success) {
                print(
                    '>>>>>>>>>>>>>>>>${await refrence.getDownloadURL()}');
              }
            }*/
              // Add user data to Firestore with profile picture URL
              await FirebaseFirestore.instance.collection('users').doc(credentials.user!.uid).set({
                'name': nameController?.text ?? '',
                'phone': phoneController?.text ?? '',
               // 'profilePictureUrl': profilePictureUrl,
                // Add additional fields as needed
              });

              await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'You Signup Successfully',
              );

              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MasterPage()));
                providerDispose();
              }
            } else {
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error Uploading Profile Picture',
              );
            }
          } else {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error In Signup',
            );
          }
        } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'This Email Already in use',
          );
        } else if (e.code == 'weak-password') {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Weak Password',
          );
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Signup Error ${e}',
        );
      }
    }
  }*/

  Future<void> signUp(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

        var credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController?.text ?? '',
          password: passwordController?.text ?? '',
        );

        if (context.mounted) {
          Navigator.pop(context);
          if (credentials.user != null) {
            // Add user data to Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(credentials.user!.uid)
                .set({
              'name': nameController?.text ?? '',
              'phone': phoneController?.text ?? '',
              // Add additional fields as needed
            });

            await QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'You Signup Successfully',
            );

            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MasterPage()));
              providerDispose();
            }
          } else {
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error In Signup',
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'This Email Already in use',
          );
        } else if (e.code == 'weak-password') {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Weak Password',
          );
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Signup Error ${e}',
        );
      }
    }
  }

  Future<void> onLogout(BuildContext contextEx) async {
    QuickAlert.show(context: contextEx, type: QuickAlertType.loading);

    await Future.delayed(const Duration(milliseconds: 300));

    await FirebaseAuth.instance.signOut();
    await GetIt.I.get<SharedPreferences>().clear();
    Navigator.pop(contextEx);
    Navigator.pushReplacement(
        contextEx, MaterialPageRoute(builder: (_) => const SplashPage()));
  }

  void openSignupPage(BuildContext context) {
    providerDispose();
    if (context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SignupPage()));
    }
  }

  void openTermsAndCondtionSPage(BuildContext context) {
    providerDispose();
    if (context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const TermsPolicyPage()));
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsString();
    }
    print("No Image Selected ");
  }
}
