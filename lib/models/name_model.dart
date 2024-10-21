import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;
  final String name;

  UserModel({
    required this.userId,
    required this.name,
  });

  Future<void> updateName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newName);
    }
  }
}
