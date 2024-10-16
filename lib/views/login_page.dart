import 'package:flutter/material.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.4, 1),
              end: Alignment(0.4, -1),
              colors: [Color.fromRGBO(224, 209, 158, 0.14), Color.fromRGBO(255, 252, 237, 1.0)],
            ),
          ),
          child: const Center(
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