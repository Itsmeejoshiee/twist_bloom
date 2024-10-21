import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../user_session.dart';
import '../../models/password_model.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    // Fetch the userId from UserSession
    userId = UserSession().getUserId();
  }

  void _updatePassword() async {
    String newPassword = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
      if (newPassword == confirmPassword) {
        UserModel userModel = UserModel(userId: userId!);
        try {
          await userModel.updatePassword(newPassword);
          Navigator.pop(context);
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')),
          );
        } catch (e) {
          // Handle error (e.g., show error message)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update password')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Edit Password',
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
            onPressed: _updatePassword,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New Password',
                  ),
                  style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, left: 32, right: 32),
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
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                  ),
                  style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
