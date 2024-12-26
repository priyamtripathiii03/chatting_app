import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static AuthService authService = AuthService._();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Account Create
  Future<void> createAccountWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Sign In
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try
        {
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          return "Success";
        }catch(e)
    {
      return e.toString();
    }
  }

  // Sign out
  Future<void> singOutUser() async {
   await _firebaseAuth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      log('email : ${user.email}');
    }
    return user;
  }
}
