import 'package:flutter/material.dart';
import '../account_page.dart';
import 'edit_email.dart';
import 'edit_password.dart';

class LoginAndSecurity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Account Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              Container(
                margin: EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoButton(context, 'Email', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditEmailPage()));
                    }),
                    _buildInfoButton(context, 'Password', () {
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
            Text(text, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins')),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}