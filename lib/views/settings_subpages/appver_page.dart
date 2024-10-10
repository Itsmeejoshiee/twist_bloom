// App Version Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/controller/gradient_background.dart';

class AppVerPage extends StatefulWidget {
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
          title: Text('App Version'),
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
                  ListTile(
                    title: Text('App Update'),
                    subtitle: Text('Your app is up to date.'),
                  ),
                  ListTile(
                    title: Text('Version'),
                    subtitle: Text('Twist & Bloom App Version 1.0.0'),
                  ),
                  ListTile(
                    title: Text('Auto update over Wi-Fi'),
                    subtitle: Text(
                        'Update app automatically when connected to Wi-Fi Network'),
                    trailing: Switch(
                      onChanged: _toggleAutoUpdate,
                      value: _isAutoUpdate,
                      activeColor: Colors.green,
                    ),
                  ),
                  ListTile(
                    title: Text('Latest Update'),
                    subtitle: Container(
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
                                'Last update was installed on September 1, 2024 at 6:12pm')
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
