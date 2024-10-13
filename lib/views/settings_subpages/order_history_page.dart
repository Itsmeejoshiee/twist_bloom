// Order History Page
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Order History'),
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
                  const ListTile(
                    title: Text('Order Tracking'),
                  ),
                  // Add Timeline Tile here
                  TimelineTile(
                    isFirst: true,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25,
                    startChild: const Column(
                      children: [
                        Text('September 1'),
                        Text('7:00 AM'),
                      ],
                    ),
                    endChild: const Text('Order Packed'),
                    beforeLineStyle: const LineStyle(color: Colors.black),
                    indicatorStyle: const IndicatorStyle(color: Colors.black),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25,
                    startChild: const Column(
                      children: [
                        Text('September 2'),
                        Text('9:00 AM'),
                      ],
                    ),
                    endChild: const Text('Order Shipped'),
                    beforeLineStyle: const LineStyle(color: Colors.black),
                    indicatorStyle: const IndicatorStyle(color: Colors.black),
                  ),
                  // Add additional Timeline Tile here

                  const SizedBox(height: 25),
                  const ListTile(
                    title: Text('Order History'),
                  ),
                  SizedBox(
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
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
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
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
