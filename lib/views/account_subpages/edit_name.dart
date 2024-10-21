import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../user_session.dart';
import '../../models/name_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final TextEditingController _nameController = TextEditingController();
  String? userId;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    // Fetch the userId from UserSession
    userId = UserSession().getUserId();
    _fetchCurrentName();
  }

  void _fetchCurrentName() {
    // Fetch the current display name from Firebase using the userId
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != null) {
      _nameController.text = user.displayName!;
    }
  }

  void _validateAndUpdateName() async {
    setState(() {
      _isValid = _nameController.text.isNotEmpty;
    });

    if (_isValid) {
      String newName = _nameController.text;
      UserModel userModel = UserModel(userId: userId!, name: newName);
      try {
        await userModel.updateName(newName);
        Navigator.pop(context);
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name updated successfully')),
        );
      } catch (e) {
        // Handle error (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update name')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Edit Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(top: 100, left: 32, right: 32, bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "John Doe",
                    errorText: !_isValid && _nameController.text.isEmpty
                        ? 'Please enter a name'
                        : null,
                  ),
                  style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _validateAndUpdateName,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color.fromRGBO(255, 182, 193, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Save'),
              ),
              const SizedBox(height: 20), // Space between button and bottom
            ],
          ),
        ),
      ),
    );
  }
}
