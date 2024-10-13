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
          title: const Center(child: Text('Terms & Conditions')),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality here
              },
            ),
          ],
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
                    title: const Text('General Terms & Conditions'),
                    subtitle: SizedBox(
                      width: 274,
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa scelerisque elementum penatibus scelerisque. Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa scelerisque elementum penatibus scelerisque. Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa scelerisque elementum penatibus scelerisque. Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa scelerisque elementum penatibus scelerisque. Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa scelerisque elementum penatibus scelerisque.',
                              textAlign: TextAlign
                                  .justify, // Justify text for better readability
                            ),
                          ],
                        ),
                      ),
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
