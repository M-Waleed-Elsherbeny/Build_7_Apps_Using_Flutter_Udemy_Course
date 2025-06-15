import 'dart:developer';
import 'package:finstagrm_app/core/router/app_route.dart';
import 'package:finstagrm_app/core/services/firebase_services.dart';
import 'package:finstagrm_app/core/widgets/height_spacer.dart';
import 'package:finstagrm_app/pages/auth/widgets/custom_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'widgets/custom_form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceWidth;
  final GlobalKey<FormState> _formKeyState = GlobalKey<FormState>();
  TextEditingController? _emailController, _passwordController;
  FirebaseServices? firebaseServices;
  String? _email, _password;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    firebaseServices = GetIt.instance.get<FirebaseServices>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
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
                  Column(
                    children: [
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
                            _email = value!;
                          });
                          log('Email: $_email');
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
                            _password = value!;
                          });
                          log('Password: $_password');
                        },
                      ),
                      HeightSpacer(height: 100),
                      CustomButton(
                        deviceWidth: _deviceWidth,
                        deviceHeight: 50,
                        onPressed: _loginUser,
                        buttonText: 'Login',
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

  void _loginUser() async {
    if (_formKeyState.currentState!.validate()) {
      _formKeyState.currentState!.save();
      bool isLogin = await firebaseServices!.loginUser(
        email: _email!,
        password: _password!,
      );
      if (isLogin && mounted) {
        Navigator.popAndPushNamed(context, AppRoute.homeScreen);
      }
    }
  }

  Widget _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.registerScreen);
      },
      child: Text(
        "Don't have an account? Register",
        style: TextStyle(
          color: Colors.blueAccent,
          // fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
