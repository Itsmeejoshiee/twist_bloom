import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class AppVerPage extends StatefulWidget {
  const AppVerPage({super.key});

  @override
  _AppVerPageState createState() => _AppVerPageState();
}

class _AppVerPageState extends State<AppVerPage> {
  bool _isAutoUpdate = false;
  final String _autoUpdateKey = 'autoUpdate';

  @override
  void initState() {
    super.initState();
    _loadAutoUpdatePreference();
  }

  // Load the auto-update preference from Hive
  Future<void> _loadAutoUpdatePreference() async {
    var box = Hive.box('settings');
    setState(() {
      _isAutoUpdate = box.get(_autoUpdateKey, defaultValue: false); // Default is false
    });
  }

  // Save the auto-update preference to Hive
  Future<void> _saveAutoUpdatePreference() async {
    var box = Hive.box('settings');
    box.put(_autoUpdateKey, _isAutoUpdate);
  }

  void _toggleAutoUpdate(bool value) {
    setState(() {
      _isAutoUpdate = value;
      _saveAutoUpdatePreference(); // Save the preference when toggled
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('App Version', style: TextStyle(fontFamily: 'Poppins')),
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
