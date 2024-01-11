// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Uint8List? _Image ;
void selectImage ()async {
    Uint8List img =await pickImage(ImageSource.gallery);
    setState((){
    _Image=img;});
}

  pickImage(ImageSource source)async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file !=null ){
      return await _file.readAsString();
    }
    print("No Image Selected ");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text(" Sign Up  "),
          leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SplashPage()));
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
                        /*Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/shopify-92b0f.appspot.com/o/products%2Fimages%20(8).png?alt=media&token=3dae3619-e738-4773-955b-c0c44942a8e1"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),*/

                        HeadlineWidget(title: 'Sign Up'),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            _Image!=null?
                            CircleAvatar(
                              radius: 64,
                                backgroundImage:MemoryImage(_Image!),
                            )
                            :CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIhsJ2D692LXEDT04mefdqZtznqnIg31FnmX5-aETP1O-rA40rRhSYbMrmMTfTVHHwoCk&usqp=CAU"),
                            ),
                            Positioned(
                                child: IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                                  withData: true,
                                  type: FileType.image,
                                );
                                var refrence = FirebaseStorage.instance
                                    .ref('Profile Picture/${result?.files.first.name}');

                                if (result?.files.first.bytes != null) {
                                  var uploadResult = await refrence.putData(
                                      result!.files.first.bytes!,
                                      SettableMetadata(contentType: 'image/png'));

                                  if (uploadResult.state == TaskState.success) {
                                    print(
                                        '>>>>>>>>>>>>>>>>${await refrence.getDownloadURL()}');
                                  }
                                }
                              },
                              icon: Icon(Icons.add_a_photo_outlined),
                            ),
                                bottom: -10 ,
                              left: 88,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: appAuthProvider.nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            suffixIcon: const Icon(Icons.people_alt_outlined),
                            fillColor: Colors.white,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: appAuthProvider.phoneController,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            suffixIcon: const Icon(Icons.phone_android),
                            fillColor: Colors.white,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: 20),
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
                        /*ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
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
                                  print(
                                      '>>>>>>>>>>>>>>>>${await refrence.getDownloadURL()}');
                                }
                              }
                            },
                            child: Text('upload image')),
                        const SizedBox(
                          height: 20,
                        ),*/
                        SizedBox(
                          height:20,
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
                          height:20,
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
