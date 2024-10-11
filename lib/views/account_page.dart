// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'landing_page.dart';
import 'account_subpages/personal_info_page.dart';
import 'account_subpages/login_security.dart';
import '../widgets/gradient_background.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountPage(),
  ));
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Account'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GradientBackground(
          child: Center(
              child: Column(
                  children: [ // First box
                    Container(
                      margin: EdgeInsets.only(
                          top: 100, left: 32, right: 32, bottom: 12),
                      padding: EdgeInsets.all(32),
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
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'assets/profile_picture.png'),
                            // Profile Picture
                            child: RawMaterialButton(
                                onPressed: () {
                                  _showPhotoOptions(context);
                                },
                                shape: CircleBorder(),
                                child: Icon(Icons.camera_alt_outlined)
                            ),
                          ),
                          SizedBox(height: 5, width: 318),
                          Text(
                            'John Doe',
                            style: TextStyle(fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),

                    Container( // Second box
                      margin: EdgeInsets.only(
                          top: 12, left: 32, right: 32, bottom: 12),
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
                        children: <Widget>[
                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.person, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                                    );
                                  },
                                  label: const Text('Personal Information',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),

                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(
                                      Icons.security, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LoginAndSecurity()),
                                    );
                                  },
                                  label: const Text('Login and Security',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),
                        ],
                      ),
                    ),

                    Container( // Third box
                      margin: EdgeInsets.only(
                          top: 12, left: 32, right: 32, bottom: 12),
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
                        children: <Widget>[
                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {},
                                  label: const Text('Delete Account',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),

                          SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      alignment: Alignment.centerLeft
                                  ),
                                  icon: Icon(Icons.logout, color: Colors.black),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()),
                                    );
                                  },
                                  label: const Text('Log Out',
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins')
                                  ))),
                        ],
                      ),
                    ),
                  ]
              )
          ),
        )
    );
  }

  void _showPhotoOptions(BuildContext context) {
    // Profile Picture Editing
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take new photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose existing photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}