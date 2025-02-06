import 'dart:developer';

import 'package:chatting_app/model/chat_model.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntroFireStore(UserModel user) async {
    await _fireStore.collection("users").doc(user.email).set({
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'isOnline': user.isOnline,
      'image': user.image,
    });
  }

  Future<void> editOnline(
      {required String email, required bool isOnline}) async {
    await _fireStore.collection("users").doc(email).update({
      "isOnline": isOnline,
    });
  }

  // read data for current user - profile
  Future<DocumentSnapshot<Map<String, dynamic>>>
      readCurrentUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await _fireStore.collection("users").doc(user!.email).get();
  }

//   read all user from fire store
  Future<QuerySnapshot<Map<String, dynamic>>>
      readAllUserFromCloudFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await _fireStore
        .collection("users")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await _fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.toMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    log(docId);
    return _fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  Future<void> updateChat(String receiver, String message, String dcId) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await _fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update(
      {'message': message},
    );
  }

  Future<void> removeChat(String dcId, String receiver) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await _fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .delete();
  }
}
