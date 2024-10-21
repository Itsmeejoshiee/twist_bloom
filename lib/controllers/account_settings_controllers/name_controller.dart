import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserName(String newName) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newName);
    }
  }
}
