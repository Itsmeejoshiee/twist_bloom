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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){},
            ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
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
            child: Container(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 16 ,vertical: 60),
              color: Colors.white,
              child: ListView(
                children: [
                  _buildListTile(Icons.notifications, 'Notification Preference'),
                  _buildListTile(Icons.language, 'Language'),
                  _buildListTile(Icons.currency_exchange, 'Currency'),
                  _buildListTile(Icons.privacy_tip, 'Privacy Settings'),
                  _buildListTile(Icons.security, 'Account Security'),
                  _buildListTile(Icons.local_shipping, 'Shipping Preferences'),
                  _buildListTile(Icons.history, 'Order History'),
                  _buildListTile(Icons.help, 'Help & Support'),
                  _buildListTile(Icons.info, 'App Version'),
                  _buildListTile(Icons.article, 'Terms & Conditions'),
                  _buildListTile(Icons.feedback, 'Feedback'),
                  _buildListTile(Icons.sync, 'Data Sync'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

  ListTile _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Add your onTap functionality here
      },
    );
  }
