import 'package:flutter/material.dart';
import 'package:twist_bloom/Views/signin_page.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(const LoadingPage());
}

void _navigateToAuthPage(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => _navigateToAuthPage(context));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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