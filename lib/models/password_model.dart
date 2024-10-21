import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;

  UserModel({required this.userId});

  Future<void> updatePassword(String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }
}
