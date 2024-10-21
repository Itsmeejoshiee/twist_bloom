import 'package:flutter/material.dart';
import '../../user_session.dart';
import '../../models/email_model.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    // Fetch the userId from UserSession
    userId = UserSession().getUserId();
    // Optionally, fetch the current email from Firebase
    _fetchCurrentEmail();
  }

  void _fetchCurrentEmail() {
    // Fetch the current email from Firebase using the userId
    // This can be done here if needed.
  }

  void _updateEmail() async {
    String newEmail = _emailController.text;
    if (newEmail.isNotEmpty) {
      UserModel userModel = UserModel(userId: userId!, email: newEmail);
      try {
        await userModel.updateEmail(newEmail);
        Navigator.pop(context);
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email updated successfully')),
        );
      } catch (e) {
        // Handle error (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Edit Email',
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
        actions: [
          TextButton(
            onPressed: _updateEmail,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
                style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
