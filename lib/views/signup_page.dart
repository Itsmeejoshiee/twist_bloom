// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:twist_bloom/Views/landing_page.dart';
import 'package:twist_bloom/Views/principal_classes.dart';
import 'package:twist_bloom/Views/signin_page.dart';
import 'package:twist_bloom/models/user_auth/firebase_auth_service.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twist_bloom/models/user_auth/firebase_auth_service.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        body: GradientBackground(
          child: Column(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        "Let's Get Started",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Continue with",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/icon/google.png",
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () async {
                            UserCredential? user =
                                await _auth.signInwithGoogle();
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            } else {
                              print("Error Occured");
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    _buildTextField(
                        labelText: "Full Name",
                        hintText: "Enter your full name",
                        controller: _fullnameController),
                    SizedBox(height: 25),
                    _buildTextField(
                        labelText: "Email",
                        hintText: "Enter your email",
                        controller: _emailController),
                    SizedBox(height: 25),
                    _buildTextField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF92B2),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(290),
                          ),
                          elevation: 4,
                        ),
                        child: Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                            ),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.none),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const SignInPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 350,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(fontFamily: 'Poppins'),
            hintStyle: TextStyle(fontFamily: 'Arimo'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String fullname = _fullnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signUpwithEmailAndPassword(fullname, email, password);

    if (user != null) {
      String? photoURL = user.photoURL;

      if (photoURL == null) {
        photoURL = "https://via.placeholder.com/150";
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print("Error Occured");
    }
  }
}
