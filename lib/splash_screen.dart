import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const AuthPage());
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.4, 1),
              end: Alignment(0.4, -1),
              colors: [Color.fromRGBO(224, 209, 158, 0.14), Color.fromRGBO(255, 252, 237, 1.0)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/TwistBloom_logo.png'),
                  width: 306.0,
                  height: 306.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}