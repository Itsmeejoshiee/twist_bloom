import 'package:flutter/material.dart';
import 'package:twist_bloom/Views/signin_page.dart';
import 'dart:async';

import 'package:twist_bloom/widgets/gradient_background.dart';

void main() {
  runApp(const LoadingPage());
}

void _navigateToAuthPage(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SignInPage(),
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
    Timer(const Duration(seconds: 2), () => _navigateToAuthPage(context));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientBackground(
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