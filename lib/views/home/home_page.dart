import 'package:chatting_app/controller/chat_controller.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:chatting_app/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var chatController = Get.put(ChatController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 270,
        child: FutureBuilder(
          future: CloudFireStoreService.cloudFireStoreService
              .readCurrentUserFromFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            Map? data = snapshot.data!.data();
            UserModel userModel = UserModel.fromMap(data!);

            return Column(
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(userModel.image ??
                            'https://www.w3schools.com/w3images/avatar2.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userModel.name ?? 'Name not available',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(userModel.email ?? 'Email not available',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),

      // AppBar
      appBar: AppBar(
        title: const Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.authService.singOutUser();
              await GoogleAuthService.googleAuthService.signOutFromGoogle();
              User? user = AuthService.authService.getCurrentUser();
              if (user == null) {
                Get.offAndToNamed('/signIn');
              }
            },
            icon: const Icon(Icons.logout,color: Colors.white,),
            tooltip: 'Log Out',
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xFF075E54),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ask Meta AI or Search',
                hintStyle: TextStyle(color: Colors.black87,fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.black87),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: CloudFireStoreService.cloudFireStoreService
                  .readAllUserFromCloudFireStore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No users available"));
                }

                List data = snapshot.data!.docs;
                List<UserModel> userList = [];
                for (var user in data) {
                  userList.add(UserModel.fromMap(user.data()));
                }

                return ListView.separated(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        chatController.getReceiver(
                            userList[index].email!, userList[index].name!);
                        Get.toNamed('/chat');
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userList[index].image ??
                            'https://www.w3schools.com/w3images/avatar2.png'),
                      ),
                      title: Text(userList[index].name ?? 'Name not available',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last message or status here',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                          Text(
                            '12:30 PM',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),

                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button for new chat
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: const Color(0xFF075E54),
        child: const Icon(Icons.message,color: Colors.white,),
      ),
    );
  }
}
