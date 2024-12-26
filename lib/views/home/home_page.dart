import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(onPressed: () async {
            await AuthService.authService.singOutUser();
            await GoogleAuthService.googleAuthService.signOutFromGoogle();
          //   user null
            User? user = AuthService.authService.getCurrentUser();
            if(user==null)
              {
               Get.offAndToNamed('/signIn');
              }
          }, icon: const Icon(Icons.logout))
        ],
      ),

    );
  }
}
