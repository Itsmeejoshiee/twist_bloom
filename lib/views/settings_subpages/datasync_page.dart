// Data Sync Page
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class DataSyncPage extends StatefulWidget {
  const DataSyncPage({super.key});

  @override
  _DataSyncPageState createState() => _DataSyncPageState();
}

class _DataSyncPageState extends State<DataSyncPage> {
  bool _isAutoSync = true;
  final String _autoSyncKey = 'autoSync';

  @override
  void initState() {
    super.initState();
    _loadAutoSyncPreference();
  }

  // Load the auto-sync preference from Hive
  Future<void> _loadAutoSyncPreference() async {
    var box = Hive.box('settings');
    setState(() {
      _isAutoSync = box.get(_autoSyncKey, defaultValue: true); // Default is true
    });
  }

  // Save the auto-sync preference to Hive
  Future<void> _saveAutoSyncPreference() async {
    var box = Hive.box('settings');
    box.put(_autoSyncKey, _isAutoSync);
  }

  void _toggleAutoSync(bool value) {
    setState(() {
      _isAutoSync = value;
      _saveAutoSyncPreference(); // Save the preference when toggled
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Data Sync', style: TextStyle(fontFamily: 'Poppins')),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Auto Sync Data', style: TextStyle(fontFamily: 'Poppins')),
                        subtitle: const Text('Automatically sync from your old device', style: TextStyle(fontFamily: 'Poppins')),
                        trailing: Switch(
                          onChanged: _toggleAutoSync,
                          value: _isAutoSync,
                          activeColor: Colors.green,
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
