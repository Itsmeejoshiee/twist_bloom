import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Help & Support'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight + 30), // Add space for AppBar height and extra padding
              Padding(
                padding: const EdgeInsets.all(16.0), // Padding around the card
                child: Card(
                  elevation: 4, // To give shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'FAQ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 274,
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                            ),
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                            ),
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                            ),
                          ),
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          'About Us',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 274,
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // Add your contact us logic here
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[300],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Contact Us'),
                      ),
                      const SizedBox(height: 20), // Adding some extra space at the bottom
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
