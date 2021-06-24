import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  // I will create afunction to upload a information to the database i.e firestore

  Future addUserDetailsToDatabase(
      String userId, Map<String, dynamic> userInfoMap) async {
    // Path
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userInfoMap);
  }
}
