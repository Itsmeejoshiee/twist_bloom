import 'package:flutter/material.dart';
import 'package:twist_bloom/Views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twist_bloom/views/signup_page.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure all plugins are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  // Initialize Hive
  try {
    await Hive.initFlutter();
    await Hive.openBox('settings');
    print("Hive initialized successfully.");
  } catch (e) {
    print("Error initializing Hive: $e");
  }

  // Run the app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
