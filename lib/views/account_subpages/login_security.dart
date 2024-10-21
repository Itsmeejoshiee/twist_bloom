import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import 'edit_email.dart';
import 'edit_password.dart';
import '../../user_session.dart';

class LoginAndSecurity extends StatelessWidget {
  const LoginAndSecurity({super.key});

  String _censorEmail(String email) {
    // Display first and last part of the email, censor the rest
    int atIndex = email.indexOf('@');
    if (atIndex > 2) {
      return email.substring(0, 2) + '****' + email.substring(atIndex - 1);
    }
    return '****'; // Fallback in case email is invalid
  }

  String _censorPassword(String password) {
    // Show only asterisks for password
    return '*' * password.length;
  }

  @override
  Widget build(BuildContext context) {
    // Fetch email and password from UserSession
    String email = UserSession().getEmail() ?? 'Unknown Email';
    String password = UserSession().getPassword() ?? 'Unknown Password';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Login & Security',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoButton(context, 'Email: ${_censorEmail(email)}', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditEmailPage()));
                    }),
                    _buildInfoButton(context, 'Password: ${_censorPassword(password)}', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPasswordPage()));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins')),
            const Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
