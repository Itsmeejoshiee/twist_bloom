import 'package:firebase_database/firebase_database.dart';
import '../../models/bio_model.dart';

class BioController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  Future<BioModel?> fetchBio(String userId) async {
    final snapshot = await _database.child(userId).child('bio').once();
    //if (snapshot.exists) {
    //  return BioModel.fromMap({'bio': snapshot.value});
    //}
    return null;
  }

  Future<void> saveBio(String userId, String bio) async {
    await _database.child(userId).update({'bio': bio});
  }
}
