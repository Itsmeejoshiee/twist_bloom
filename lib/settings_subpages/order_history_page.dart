// Order History Page
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:twist_bloom/gradient_background.dart';

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
              elevation: 4, // To give shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Order Tracking'),
                  ),
                  // Add Timeline Tile here
                  TimelineTile(
                    isFirst: true,
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25,
                    startChild: Column(
                      children: [
                        Text('September 1'),
                        Text('7:00 AM'),
                      ],
                    ),
                    endChild: Text('Order Packed'),
                    beforeLineStyle: LineStyle(color: Colors.black),
                    indicatorStyle: IndicatorStyle(color: Colors.black),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.25,
                    startChild: Column(
                      children: [
                        Text('September 2'),
                        Text('9:00 AM'),
                      ],
                    ),
                    endChild: Text('Order Shipped'),
                    beforeLineStyle: LineStyle(color: Colors.black),
                    indicatorStyle: IndicatorStyle(color: Colors.black),
                  ),
                  // Add additional Timeline Tile here

                  SizedBox(height: 25),
                  ListTile(
                    title: Text('Order History'),
                  ),
                  Container(
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
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Lorem ipsum odor amet, consectetuer adipiscing elit. Ultrices malesuada massa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
