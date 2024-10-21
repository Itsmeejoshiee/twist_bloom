import 'package:firebase_auth/firebase_auth.dart';

class PhoneModel {
  final String userId;

  PhoneModel({required this.userId});

  Future<void> updatePhoneNumber(String phoneNumber, String smsCode, String verificationId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Use the verification ID and SMS code to create the phone auth credential
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        // Update the user's phone number
        await user.updatePhoneNumber(credential);
      } catch (e) {
        throw Exception('Failed to update phone number: $e');
      }
    }
  }
}
