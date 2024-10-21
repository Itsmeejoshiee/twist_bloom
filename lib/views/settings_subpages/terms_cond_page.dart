// Terms And Conditions Page
import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Terms & Conditions', style: TextStyle(fontFamily: 'Poppins')),
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
          child: SingleChildScrollView( // Make the entire body scrollable
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
                          title: const Text('General Terms & Conditions', style: TextStyle(fontFamily: 'Poppins')),
                          subtitle: SizedBox(
                            width: 274,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Welcome to Twist and Bloom. By accessing or using our app, you agree to comply with and be bound by these Terms and Conditions. If you do not agree to these Terms, please do not use our app.\n\n'
                                  '1. Acceptance of Terms\n\n'
                                  'By using the app, you affirm that you are at least 18 years old or possess the consent of a parent or guardian. You agree to comply with all applicable laws and regulations related to your use of the app.\n\n'
                                  '2. User Accounts\n\n'
                                  'To access certain features of the app, you may be required to create an account. When creating an account:\n'
                                  '- You must provide accurate and complete information.\n'
                                  '- You are responsible for maintaining the confidentiality of your account credentials.\n'
                                  '- You are responsible for all activities that occur under your account.\n'
                                  'If you suspect any unauthorized use of your account, please contact us immediately.\n\n'
                                  '3. Orders and Payments\n\n'
                                  'When you place an order through the app:\n'
                                  '- You agree to pay the full amount for the products, including any applicable taxes and shipping fees.\n'
                                  '- All payments are processed through secure third-party payment processors. We do not store your payment information.\n'
                                  '- If your payment is declined, your order will not be processed.\n\n'
                                  '4. Product Availability\n\n'
                                  'While we strive to provide accurate product descriptions and availability:\n'
                                  '- We do not guarantee that all products will be in stock at the time of your order.\n'
                                  '- If a product becomes unavailable after your order is placed, we will notify you as soon as possible and provide options for resolution.\n\n'
                                  '5. Delivery\n\n'
                                  'We aim to deliver your order on the selected date. However, delivery times may vary due to:\n'
                                  '- Location\n'
                                  '- Weather conditions\n'
                                  '- Unforeseen circumstances\n'
                                  'We are not liable for any delays in delivery. If you have specific delivery instructions, please include them at the time of order.\n\n'
                                  '6. Returns and Refunds\n\n'
                                  'Due to the perishable nature of flowers, we have a strict no-return policy. However, if you receive:\n'
                                  '- Damaged products\n'
                                  '- Incorrect items\n'
                                  'Please contact our customer service within 24 hours of delivery. We will assess the situation and, if warranted, provide a replacement or refund.\n\n'
                                  '7. Cancellations\n\n'
                                  'You may cancel your order up to 24 hours before the scheduled delivery date. After that, cancellations may not be possible due to the perishable nature of the products.\n\n'
                                  '8. Intellectual Property\n\n'
                                  'All content, trademarks, and other intellectual property displayed in the app are the property of [Company Name] or our licensors. You may not use, reproduce, distribute, or create derivative works without our prior written consent.\n\n'
                                  '9. User Conduct\n\n'
                                  'You agree to use the app in a manner that complies with applicable laws and regulations. You will not:\n'
                                  '- Post or transmit any unlawful, harmful, or defamatory content.\n'
                                  '- Attempt to interfere with the functioning of the app.\n'
                                  '- Use any automated means to access the app for any purpose without our express written permission.\n\n'
                                  '10. Contact Us\n\n'
                                  'If you have any questions about these Terms, please contact us at:\n\n'
                                  '- twistandbloom@gmail.com\n'
                                  '- 09123456789\n',
                                    style: TextStyle(fontFamily: 'Poppins')
                                ),
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
      ),
    );
  }
}
