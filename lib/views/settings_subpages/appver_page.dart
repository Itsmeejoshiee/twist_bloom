import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class AppVerPage extends StatefulWidget {
  const AppVerPage({super.key});

  @override
  _AppVerPageState createState() => _AppVerPageState();
}

class _AppVerPageState extends State<AppVerPage> {
  bool _isAutoUpdate = false;

  void _toggleAutoUpdate(bool value) {
    setState(() {
      _isAutoUpdate = value;
      // Auto Update Logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('App Version'),
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
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the top
            children: [
              const SizedBox(height: kToolbarHeight + 30), // Add space equal to the height of AppBar and some extra padding
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
                        title: Text('App Update'),
                        subtitle: Text('Your app is up to date.'),
                      ),
                      const ListTile(
                        title: Text('Version'),
                        subtitle: Text('Twist & Bloom App Version 1.0.0'),
                      ),
                      ListTile(
                        title: const Text('Auto update over Wi-Fi'),
                        subtitle: const Text(
                            'Update app automatically when connected to Wi-Fi Network'),
                        trailing: Switch(
                          onChanged: _toggleAutoUpdate,
                          value: _isAutoUpdate,
                          activeColor: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: const Text('Latest Update'),
                        subtitle: SizedBox(
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
                                  'Last update was installed on September 1, 2024 at 6:12pm'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
