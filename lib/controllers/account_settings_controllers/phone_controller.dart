import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserPhoneNumber(String phoneNumber) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: "YOUR_VERIFICATION_ID",
        smsCode: phoneNumber,
      ));
    }
  }
}
