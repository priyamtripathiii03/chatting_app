

import 'package:chatting_app/model/chat_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:chatting_app/views/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatController.receiverName.value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: CloudFireStoreService.cloudFireStoreService
                    .readChatFromFireStore(chatController.receiverEmail.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  List<ChatModel> chatList = [];
                  List<String> docIdList = [];
                  for (QueryDocumentSnapshot snap in data) {
                    docIdList.add(snap.id);
                    chatList.add(ChatModel.fromMap(snap.data() as Map));
                  }
                  return ListView.builder(
                    reverse: false, // Reverse the chat order so that new messages appear at the bottom
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      bool isSender = chatList[index].sender ==
                          AuthService.authService.getCurrentUser()!.email!;
                      return GestureDetector(
                        onLongPress: () {
                          if (isSender) {
                            chatController.txtUpdateMessage =
                                TextEditingController(text: chatList[index].message);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Update Message'),
                                  content: TextField(
                                    controller: chatController.txtUpdateMessage,
                                    decoration: const InputDecoration(
                                      labelText: 'Edit your message',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        String docId = docIdList[index];
                                        CloudFireStoreService
                                            .cloudFireStoreService
                                            .updateChat(
                                            chatController
                                                .receiverEmail.value,
                                            chatController
                                                .txtUpdateMessage.text,
                                            docId);
                                        Get.back();
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        onDoubleTap: () {
                          if (isSender) {
                            CloudFireStoreService.cloudFireStoreService.removeChat(
                                docIdList[index], chatController.receiverEmail.value);
                          }
                        },
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? Colors.teal[200]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chatList[index].message,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: chatController.txtMessage,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {

                      }, icon: const Icon(Icons.attach_file)),
                      IconButton(
                        onPressed: () async {
                          if (chatController.txtMessage.text.isNotEmpty) {
                            ChatModel chat = ChatModel(
                              sender: AuthService.authService.getCurrentUser()!.email!,
                              receiver: chatController.receiverEmail.value,
                              message: chatController.txtMessage.text,
                              time: Timestamp.now(),
                            );
                            await CloudFireStoreService.cloudFireStoreService.addChatInFireStore(chat);
                            chatController.txtMessage.clear();
                          }
                        },
                        icon: const Icon(Icons.send, color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
