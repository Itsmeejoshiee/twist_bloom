import 'package:flutter/material.dart';
import '../account_page.dart';

class EditBioPage extends StatefulWidget {
  @override
  _EditBioPageState createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Edit Bio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.black)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(border: InputBorder.none, hintText: "Set bio here"),
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}