// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, 1),
          end: Alignment(0.4, -1),
          colors: [
            Color.fromRGBO(224, 209, 158, 0.14),
            Color.fromRGBO(255, 252, 237, 1.0)
          ],
        ),
      ),
      child: child,
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 4, // To Give Shadow Effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), //Rounded Corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView(
                  shrinkWrap: true, // Listview only uses the space it needs
                  padding: EdgeInsets.all(8), // spacing around the ListView
                  children: [
                    _buildListTile(
                        context,
                        Icons.notifications,
                        'Notification Preference',
                        NotificationPreferencePage()),
                    _buildListTile(
                        context, Icons.language, 'Language', LanguagePage()),
                    _buildListTile(context, Icons.currency_exchange, 'Currency',
                        CurrencyPage()),
                    _buildListTile(context, Icons.privacy_tip,
                        'Privacy Settings', PrivacySettingsPage()),
                    _buildListTile(context, Icons.security, 'Account Security',
                        SecurityPage()),
                    _buildListTile(context, Icons.local_shipping,
                        'Shipping Preferences', ShippingPrefPage()),
                    _buildListTile(context, Icons.history, 'Order History',
                        OrderHistoryPage()),
                    _buildListTile(
                        context, Icons.help, 'Help & Support', HelpPage()),
                    _buildListTile(
                        context, Icons.info, 'App Version', AppVerPage()),
                    _buildListTile(context, Icons.article, 'Terms & Conditions',
                        TermsAndConditionsPage()),
                    _buildListTile(
                        context, Icons.feedback, 'Feedback', FeedBackPage()),
                    _buildListTile(
                        context, Icons.sync, 'Data Sync', DataSyncPage()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

// Notification Preference Page

class NotificationPreferencePage extends StatefulWidget {
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
        title: Text('Notification Preference'),
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
            elevation: 4, // To Give Shadow Effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded Corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    title: Text(
                  'Order Notifications',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                )),
                // Radio button for 'By Order'
                ListTile(
                  title: Text('By Order',
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
                  title: Text('By Time',
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
                ListTile(
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
                  title: Text('Lockscreen Notifications',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 20)),
                  trailing: Switch(
                    onChanged: _toggleLockScreen,
                    value: _isLockScreenOn,
                    activeColor: Colors.green,
                  ),
                ),
                ListTile(
                  title: Text('Do Not Disturb',
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
      ),
    );
  }
}

//Language Page

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Language'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            //Change to Icon Button for finals
                            leading: Icon(Icons.language),
                            title: Text(
                              'English (United States)',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Poppins'),
                            ),
                          ),
                          ListTile(
                              title: Text(
                            'Keyboard Settings',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 20),
                          )),
                          ListTile(
                              title: Text(
                                'English (United States)',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 15),
                              ),
                              //Change to Icon Button for finals
                              leading: Icon(Icons.keyboard)),
                        ],
                      ))))),
    );
  }
}

//Currency Page

class CurrencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Currency'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              'Preferred Currency',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 20),
                            ),
                            subtitle: Text('Philippine Peso (Php)'),
                          ),
                          SizedBox(height: 40),
                          ListTile(
                            title: Text('Transaction History',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20)),
                          ),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))))),
    );
  }
}

//Privacy Settings Page

class PrivacySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Privacy Settings'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ))))),
    );
  }
}

//Security Page

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Account Security'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Two Factor Authentication'),
                          ),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text('Phone Number'),
                                  Text('09123456789')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text('Email Address'),
                                  Text('spo1jkc@gmail.com')
                                ],
                              ),
                            ),
                          ),
                          ListTile(title: Text('Password')),
                          Container(
                            width: 274,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text('Current Password'),
                                  Text('********')
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 274,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [Text('Change Password'), Text('')],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('Login History'),
                          ),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40)
                        ],
                      ))))),
    );
  }
}

//Shipping Preference Page

class ShippingPrefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Shipping Preference'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Shipping Address'),
                          ),
                          Text('Region/City/District'),
                          Container(
                            width: 274,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [Text('')],
                              ),
                            ),
                          ),
                          Text('Street/Building Name'),
                          Container(
                            width: 274,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [Text('')],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('Delivery'),
                            subtitle: Text('Standard Shipping'),
                          ),
                          SizedBox(height: 20)
                        ],
                      ))))),
    );
  }
}

//Order History Page

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Order History'),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(title: Text('Order Tracking')),
                          //Add Timeline Tile here

                          //Add Timeline Tile here
                          ListTile(
                            title: Text('Order History'),
                          ),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                      'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ))))),
    );
  }
}

//Help Page

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Center(child: Text('Help & Support')),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ))))),
    );
  }
}

//App Version Page

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
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Center(child: Text('App Version')),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
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
                              )),
                        ],
                      ))))),
    );
  }
}

//Terms And Conditions Page

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Center(child: Text('Terms & Conditions')),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container()),
    );
  }
}

//Feedback Page

class FeedBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Center(child: Text('Feedback')),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ))))),
    );
  }
}

//Data Sync Page

class DataSyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Center(child: Text('Data Sync')),
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
                      elevation: 4, // To Give Shadow Effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), //Rounded Corners
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ))))),
    );
  }
}
