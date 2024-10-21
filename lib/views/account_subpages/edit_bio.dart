import 'package:flutter/material.dart';
import 'package:twist_bloom/widgets/gradient_background.dart';
import '../../models/bio_model.dart';
import '../../controllers/account_settings_controllers/bio_controller.dart';
import '../../user_session.dart';

class EditBioPage extends StatefulWidget {
  const EditBioPage({super.key});

  @override
  _EditBioPageState createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {
  final BioController _controller = BioController();
  BioModel? _bioModel;
  final TextEditingController _bioController = TextEditingController();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    // Get userId from UserSession
    setState(() {
      _userId = UserSession().getUserId(); // Fetch userId from the session
    });

    // If userId is available, load bio data
    if (_userId != null) {
      _loadBio();
    } else {
      // Handle case when userId is null (e.g., redirect or show error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not found. Please log in again.')),
      );
      Navigator.pop(context); // Pop the current screen to prevent further issues
    }
  }

  Future<void> _loadBio() async {
    if (_userId != null) {
      _bioModel = await _controller.fetchBio(_userId!);
      if (_bioModel != null) {
        setState(() {
          _bioController.text = _bioModel!.bio; // Set text in the text field
        });
      }
    }
  }

  Future<void> _saveBio() async {
    if (_bioController.text.isNotEmpty && _userId != null) {
      await _controller.saveBio(_userId!, _bioController.text); // Save bio using userId
      Navigator.pop(context); // Go back after saving
    } else {
      // Handle empty bio or null userId case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save bio. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Edit Bio',
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
            onPressed: _saveBio,
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Column(
          children: [
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
                controller: _bioController,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Set bio here",
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
