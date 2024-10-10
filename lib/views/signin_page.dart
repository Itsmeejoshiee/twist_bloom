// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:twist_bloom/Views/landing_page.dart';
import 'package:twist_bloom/Views/login_page.dart';
import 'dart:math' as math;

void main() {
  runApp(const SignInPage());
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.4, 1),
              end: Alignment(0.4, -1),
              colors: [
                Color.fromRGBO(224, 209, 158, 0.14),
                Color.fromRGBO(255, 252, 237, 1.0)
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        "Let's Get Started",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Continue with",
                      style: TextStyle(fontSize: 14),
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
                          onPressed: () {
//Dito yung sa google pati wala pa icon ng google paking shit walang google icon yung paking flutter
                          },
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.facebook,
                              size: 40, color: Colors.blue),
                          onPressed: () {
//Dito yung sa fb
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    _buildTextField(
                      labelText: "Full Name",
                      hintText: "Enter your full name",
                    ),
                    SizedBox(height: 25),
                    _buildTextField(
                      labelText: "E-mail",
                      hintText: "Enter your email",
                    ),
                    SizedBox(height: 25),
                    _buildTextField(
                      labelText: "Password",
                      hintText: "Enter your password",
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          },
                          child: Text("Register"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF92B2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(290),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                              ),
                              TextSpan(
                                text: "Log in",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.none),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
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
}
