import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;
  final String email;

  UserModel({
    required this.userId,
    required this.email,
  });

  Future<void> updateEmail(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateEmail(newEmail);
    }
  }
}
