// Security Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Account Security'),
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
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 4, // To give shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    title: Text('Two Factor Authentication'),
                  ),
                  SizedBox(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text('Phone Number'),
                          Text('09123456789'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text('Email Address'),
                          Text('spo1jkc@gmail.com'),
                        ],
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Password'),
                  ),
                  SizedBox(
                    width: 274,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text('Current Password'),
                          Text('********'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 274,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text('Change Password'),
                          Text(''),
                        ],
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Login History'),
                  ),
                  SizedBox(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
