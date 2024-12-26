import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
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
        width: 250,
        child: FutureBuilder(future: CloudFireStoreService.cloudFireStoreService.readCurrentUserFromFireStore(),
            builder: (context,snapshot){
          if(snapshot.hasError)
            {
              return Center(child: Text(snapshot.error.toString()));
            }
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
              Map? data = snapshot.data!.data();
              UserModel userModel = UserModel.fromMap(data!);
              return Column(
                children: [
                  DrawerHeader(child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userModel.image!),)),
                  Text(userModel.name!),
                  Text(userModel.email!),
                  Text(userModel.phone!),
                ],
              );
            }
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
      body: FutureBuilder(future: CloudFireStoreService.cloudFireStoreService.readAllUserFromCloudFireStore(),
          builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        List data = snapshot.data!.docs;
        List<UserModel> userList =[];
        for(var user in data)
          {
           userList.add(UserModel.fromMap( user.data()));
          }
        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index){
          },
        );
    },
      ),
    );
  }
}
