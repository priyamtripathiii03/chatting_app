import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: const Color(0xFF075E54),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // You can implement search functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  return const Center(child: Text("No contacts available"));
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
                        // Navigate to the chat page when tapping on a contact
                        // Example: Get.toNamed('/chat');
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userList[index].image ??
                            'https://www.w3schools.com/w3images/avatar2.png'),
                      ),
                      title: Text(userList[index].name ?? 'Name not available',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(userList[index].email ?? 'Email not available'),
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

      // Floating Action Button to add a new contact
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the page where users can add a new contact
          // Example: Get.toNamed('/add-contact');
        },
        backgroundColor: const Color(0xFF075E54),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
