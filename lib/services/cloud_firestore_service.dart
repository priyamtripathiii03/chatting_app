import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService
{
  CloudFireStoreService._();
  static CloudFireStoreService cloudFireStoreService = CloudFireStoreService._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> inserUserIntroFireStore(String email)
  async {
    await _fireStore.collection("users").doc(email).set({
      'email':email
    });
  }
}