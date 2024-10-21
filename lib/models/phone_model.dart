import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;

  UserModel({required this.userId});

  Future<void> updatePhoneNumber(String phoneNumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: "YOUR_VERIFICATION_ID",
        smsCode: phoneNumber,
      ));
    }
  }
}
