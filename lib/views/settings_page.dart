import 'package:flutter/material.dart';
import 'settings_subpages/settings_subpages.dart';
import '../widgets/gradient_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFAFA), // Make app bar transparent
        title: const Text('Settings',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Ensures no default back button
        actions: [], // Removes action icons (like search)
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
                Flexible( // Use Flexible to handle overflow better
                  child: ListView(
                    shrinkWrap: true, // ListView only uses the space it needs
                    padding: EdgeInsets.all(8), // spacing around the ListView
                    children: [
                      _buildListTile(
                          context,
                          Icons.notifications,
                          'Notification Preference',
                          NotificationPreferencePage()),
                      _buildListTile(
                          context, Icons.language, 'Language', LanguagePage()),
                      _buildListTile(context, Icons.currency_exchange,
                          'Currency', CurrencyPage()),
                      _buildListTile(context, Icons.privacy_tip,
                          'Privacy Settings', PrivacySettingsPage()),
                      _buildListTile(context, Icons.security,
                          'Account Security', SecurityPage()),
                      _buildListTile(context, Icons.local_shipping,
                          'Shipping Preferences', ShippingPrefPage()),
                      _buildListTile(context, Icons.history, 'Order History',
                          OrderHistoryPage()),
                      _buildListTile(
                          context, Icons.help, 'Help & Support', HelpPage()),
                      _buildListTile(
                          context, Icons.info, 'App Version', AppVerPage()),
                      _buildListTile(context, Icons.article,
                          'Terms & Conditions', TermsAndConditionsPage()),
                      _buildListTile(
                          context, Icons.feedback, 'Feedback', FeedBackPage()),
                      _buildListTile(
                          context, Icons.sync, 'Data Sync', DataSyncPage()),
                    ],
                  ),
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
