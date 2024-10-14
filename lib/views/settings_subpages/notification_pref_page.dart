// Notification Preference Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class NotificationPreferencePage extends StatefulWidget {
  const NotificationPreferencePage({super.key});

  @override
  _NotificationPreferencePageState createState() =>
      _NotificationPreferencePageState();
}

class _NotificationPreferencePageState
    extends State<NotificationPreferencePage> {
  bool _isLockScreenOn = false;
  bool _isDoNotDisturbOn = false;
  // Placeholder for radio button selection
  String? _placeholder;
  // Options for radio button
  final List<String> _orderNotifOptions = ['By Order', 'By Time'];
  //Volume Slider
  double _currentVolumeSlider = 20;

  void _toggleLockScreen(bool value) {
    setState(() {
      _isLockScreenOn = value;
      // Lock Screen Notification Logic
    });
  }

  void _toggleDoNotDisturb(bool value) {
    setState(() {
      _isDoNotDisturbOn = value;
      // Do Not Disturb Logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Notification Preference'),
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
                elevation: 4, // To Give Shadow Effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded Corners
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                        title: Text(
                          'Order Notifications',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                        )),
                    // Radio button for 'By Order'
                    ListTile(
                      title: const Text('By Order',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      leading: Radio<String>(
                        value: 'By Order',
                        groupValue: _placeholder,
                        onChanged: (String? value) {
                          setState(() {
                            _placeholder = value;
                            // Placeholder logic for 'By Order'
                          });
                        },
                      ),
                    ),
                    // Radio button for 'By Time'
                    ListTile(
                      title: const Text('By Time',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                      leading: Radio<String>(
                        value: 'By Time',
                        groupValue: _placeholder,
                        onChanged: (String? value) {
                          setState(() {
                            _placeholder = value;
                            // Placeholder logic for 'By Time'
                          });
                        },
                      ),
                    ),
                    const ListTile(
                        title: Text('Notification Volume',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 20))),
                    Slider(
                      value: _currentVolumeSlider,
                      min: 0.0,
                      max: 100.0,
                      divisions: 5,
                      onChanged: (double value) {
                        setState(() {
                          _currentVolumeSlider = value;
                        });
                      },
                    ),

                    ListTile(
                      title: const Text('Lockscreen Notifications',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                      trailing: Switch(
                        onChanged: _toggleLockScreen,
                        value: _isLockScreenOn,
                        activeColor: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: const Text('Do Not Disturb',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                      trailing: Switch(
                        onChanged: _toggleDoNotDisturb,
                        value: _isDoNotDisturbOn,
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
    );
  }
}
