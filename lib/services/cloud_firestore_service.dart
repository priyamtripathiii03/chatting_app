import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService
{
  CloudFireStoreService._();
  static CloudFireStoreService cloudFireStoreService = CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> inserUserIntroFireStore(String email)
  async {
    await fireStore.collection("users").doc(email).set({
      'email':email
    });
  }
}