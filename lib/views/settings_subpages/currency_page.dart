import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Currency'),
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
                      const ListTile(
                        title: Text(
                          'Preferred Currency',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text('Philippine Peso (Php)'),
                      ),
                      const SizedBox(height: 40),
                      const ListTile(
                        title: Text(
                          'Transaction History',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
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
