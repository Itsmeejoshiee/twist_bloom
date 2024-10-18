// Language Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Language'),
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
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4, // To give shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.language),
                        title: Text(
                          'English (United States)',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Keyboard Settings',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.keyboard),
                        title: Text(
                          'English (United States)',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                      ),
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
