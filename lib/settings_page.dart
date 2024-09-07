// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsPage());
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Center(child: Text('Settings')),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 20, color: Colors.black),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Notification Preference')
                  ],
                ),
                Row(
                  children: [
                    Text('Language')
                  ],
                ),
                Row(
                  children: [
                    Text('Privacy Settings')
                  ],
                ),
                Row(
                  children: [
                    Text('Account Security')
                  ],
                ),
                Row(
                  children: [
                    Text('Shipping Preferences')
                  ],
                ),
                Row(
                  children: [
                    Text('Order History')
                  ],
                ),
                Row(
                  children: [
                    Text('Help & Support')
                  ],
                ),
                Row(
                  children: [
                    Text('App Version')
                  ],
                ),
                Row(
                  children: [
                    Text('Terms & Condition')
                  ],
                ),
                Row(
                  children: [
                    Text('Feedback')
                  ],
                ),
                Row(
                  children: [
                    Text('Data Sync')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
