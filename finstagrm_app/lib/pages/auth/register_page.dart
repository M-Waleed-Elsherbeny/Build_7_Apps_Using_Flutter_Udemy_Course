import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:finstagrm_app/core/widgets/height_spacer.dart';
import 'package:finstagrm_app/pages/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/custom_form_fields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKeyState = GlobalKey<FormState>();
  TextEditingController? _emailController,
      _passwordController,
      _usernameController;
  String? username, email, password;
  bool _isPasswordVisible = false;
  double? _deviceWidth, _deviceHeight;

  FilePickerResult? filePickerResult;
  File? image;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: _formKeyState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _titleLogin(),
                  _profileImageWidget(),
                  Column(
                    children: [
                      CustomFormFields(
                        controller: _usernameController,
                        hintText: "Enter your Name",
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: SizedBox.shrink(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          username = value!;
                          setState(() {});
                        },
                      ),
                      HeightSpacer(height: 50),
                      CustomFormFields(
                        controller: _emailController,
                        hintText: 'Enter your Email',
                        labelText: 'Email',
                        suffixIcon: SizedBox.shrink(),
                        prefixIcon: Icon(Icons.email),
                        validator: (value) {
                          bool emailValid = value!.contains(
                            RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                            ),
                          );
                          if (value.isEmpty) {
                            return 'Please enter Your Email';
                          }
                          return emailValid
                              ? null
                              : "Please enter a valid email";
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value!;
                          });
                        },
                      ),
                      HeightSpacer(height: 50),
                      CustomFormFields(
                        controller: _passwordController,
                        isPassword: !_isPasswordVisible,
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter your password'
                                    : value.length >= 6
                                    ? null
                                    : 'Password must be at least 6 characters',
                        onSaved: (value) {
                          setState(() {
                            password = value!;
                          });
                        },
                      ),
                      HeightSpacer(height: 100),
                      CustomButton(
                        deviceWidth: _deviceWidth,
                        deviceHeight: 50,
                        onPressed: _registerUser,
                        buttonText: 'Register',
                      ),
                    ],
                  ),
                  _registerButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleLogin() {
    return Text(
      'Finstagram',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _profileImageWidget() {
    return GestureDetector(
      onTap: () async {
        filePickerResult = await FilePicker.platform.pickFiles();
        if (filePickerResult != null) {
          image = File(filePickerResult!.files.first.path!);
          setState(() {});
        } else {
          _showSnackBar('No image selected', Colors.redAccent);
        }
      },
      child:
          image == null
              ? Container(
                width: _deviceHeight! * 0.15,
                height: _deviceHeight! * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.redAccent, width: 2.w),
                ),
                child: Icon(
                  Icons.add_a_photo,
                  size: _deviceHeight! * 0.1,
                  color: Colors.redAccent,
                ),
              )
              : Container(
                width: _deviceHeight! * 0.15,
                height: _deviceHeight! * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(image!),
                    //         : NetworkImage("https://i.pravatar.cc/300"),
                    // fit: BoxFit.cover,
                    // )
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.redAccent, width: 2.w),
                ),
              ),
    );
  }

  void _registerUser() {
    if (image == null) {
      _showSnackBar('Please select a profile image', Colors.redAccent);
      return;
    }
    if (_formKeyState.currentState!.validate() && image != null) {
      _formKeyState.currentState!.save();
      
      // FilePicker.platform
      //     .saveFile(
      //       dialogTitle: 'Please select an output file:',
      //       fileName: 'output-file.pdf',
      //       bytes: image!.readAsBytesSync(),
      //     )
      //     .then((String? outputFile) {
      //       if (outputFile != null) {
      //         // File saved successfully
      //         _showSnackBar('File saved: $outputFile', Colors.greenAccent);
      //         log(outputFile);
      //       } else {
      //         _showSnackBar('File save canceled', Colors.redAccent);
      //       }
      //     });
      FocusScope.of(context).unfocus();
      _showSnackBar('Registration Successfully !!!', Colors.greenAccent);
      Navigator.pop(context);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: _deviceWidth! * 0.9,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Do have an account? Login",
        style: TextStyle(
          color: Colors.blueAccent,
          // fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
