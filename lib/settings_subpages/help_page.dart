// Help Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/gradient_background.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Help & Support'),
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
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 4, // To give shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text('FAQ'),
                  ),
                  Container(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('About us'),
                  ),
                  Container(
                    width: 274,
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Placeholder();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Contact us'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
