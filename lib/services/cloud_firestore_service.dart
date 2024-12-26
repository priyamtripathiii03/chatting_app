import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFireStoreService
{
  CloudFireStoreService._();
  static CloudFireStoreService cloudFireStoreService = CloudFireStoreService._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntroFireStore(UserModel user)
  async {
    await _fireStore.collection("users").doc(user.email).set({
      'email':user.email,
      'name':user.name,
      'phone':user.phone,
      'token':user.token,
      'image':user.image,

    });
  }
  // read data for current user - profile
  Future<DocumentSnapshot<Map<String, dynamic>>> readCurrentUserFromFireStore()
  async {
    User? user = AuthService.authService.getCurrentUser();
    return await _fireStore.collection("users").doc(user!.email).get();
  }
//   read all user from fire store
Future<QuerySnapshot<Map<String, dynamic>>> readAllUserFromCloudFireStore()
  async{
    User? user = AuthService.authService.getCurrentUser();
    return await _fireStore.collection("users").where("email",isNotEqualTo: user!.email).get();

  }

}