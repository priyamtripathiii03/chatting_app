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
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DrawerHeader(
                  child: CircleAvatar(
                radius: 50,
                backgroundImage: AuthService
                            .authService
                            .getCurrentUser()!
                            .photoURL ==
                        null
                    ? NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png')
                    : NetworkImage(
                        AuthService.authService.getCurrentUser()!.photoURL!),
              )),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AuthService.authService.getCurrentUser()!.email!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.drive_file_rename_outline),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AuthService.authService.getCurrentUser()!.displayName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.authService.singOutUser();
                await GoogleAuthService.googleAuthService.signOutFromGoogle();
                //   user null
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
