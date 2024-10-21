import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twist_bloom/views/signup_page.dart';
import 'account_subpages/personal_info_page.dart';
import 'account_subpages/login_security.dart';
import 'principal_classes.dart';
import '../widgets/gradient_background.dart';
import '../user_session.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? userName; // Variable to hold the user name

  @override
  void initState() {
    super.initState();
    _fetchCurrentName();
  }

  void _fetchCurrentName() {
    // Fetch the current display name from Firebase
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.displayName != null) {
      setState(() {
        userName = user.displayName; // Update the userName
      });
    } else {
      setState(() {
        userName = 'User'; // Fallback if no display name is found
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch userId from UserSession
    String? userId = UserSession().getUserId();

    // Fetch the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Center(
          child: Column(
            children: [
              // First box
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(
                    top: 100, left: 32, right: 32, bottom: 12),
                padding: const EdgeInsets.all(32),
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
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      backgroundImage:
                          const AssetImage('assets/user_avatar.jpg'),
                      child: RawMaterialButton(
                        onPressed: () {
                          _showPhotoOptions(context);
                        },
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    const SizedBox(height: 5, width: 318),
                    Text(
                      userName ??
                          'User', // Use fetched user name or fallback to 'User'
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),

              // Second box
              Container(
                margin: const EdgeInsets.only(
                    top: 12, left: 32, right: 32, bottom: 12),
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
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.centerLeft),
                        icon: const Icon(Icons.person, color: Colors.black),
                        onPressed: () {
                          if (userId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalInfoPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('User ID not found')),
                            );
                          }
                        },
                        label: const Text(
                          'Personal Information',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.centerLeft),
                        icon: const Icon(Icons.security, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginAndSecurity()),
                          );
                        },
                        label: const Text(
                          'Login and Security',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Third box
              Container(
                margin: const EdgeInsets.only(
                    top: 12, left: 32, right: 32, bottom: 12),
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
                  children: <Widget>[
                    // Delete Account button
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.centerLeft),
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          _showDeleteAccountDialog(context);
                        },
                        label: const Text(
                          'Delete Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),

                    // Log Out button
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.centerLeft),
                        icon: const Icon(Icons.logout, color: Colors.black),
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        label: const Text(
                          'Log Out',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoOptions(BuildContext context) {
    // Profile Picture Editing
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take new photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose existing photo'),
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

  void _showDeleteAccountDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Are you sure you want to delete your account?'),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                String password = passwordController.text;
                if (password.isNotEmpty) {
                  // Proceed with account deletion logic
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                // Proceed with log out logic
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
