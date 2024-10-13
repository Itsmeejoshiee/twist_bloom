// Data Sync Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class DataSyncPage extends StatefulWidget {
  const DataSyncPage({super.key});

  @override
  _DataSyncPageState createState() => _DataSyncPageState();
}

class _DataSyncPageState extends State<DataSyncPage> {
  bool _isAutoSync = true;

  void _toggleAutoSync(bool value) {
    setState(() {
      _isAutoSync = value;
      // Auto Sync Logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Data Sync'),
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
                  ListTile(
                    title: const Text('Auto Sync Data'),
                    subtitle: const Text('Automatically sync from your old device'),
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
        ),
      ),
    );
  }
}
