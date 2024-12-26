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
        title: Text(chatController.receiverName.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                    return Center(
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      chatList.length,
                      (index) => GestureDetector(
                        onLongPress: () {
                          if (chatList[index].sender ==
                              AuthService.authService
                                  .getCurrentUser()!
                                  .email!) {
                            chatController.txtUpdateMessage =
                                TextEditingController(
                                    text: chatList[index].message);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Update'),
                                  content: TextField(
                                    controller: chatController.txtUpdateMessage,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        String dcId = docIdList[index];
                                        CloudFireStoreService
                                            .cloudFireStoreService
                                            .updateChat(
                                                chatController
                                                    .receiverEmail.value,
                                                chatController
                                                    .txtUpdateMessage.text,
                                                dcId);
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
                          if(chatList[index].sender == AuthService.authService.getCurrentUser()!.email!)
                            {
                              CloudFireStoreService.cloudFireStoreService.removeChat(docIdList[index], chatController.receiverEmail.value);
                            }

                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          alignment: (chatList[index].sender ==
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!)
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(chatList[index].message!),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: chatController.txtMessage,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        ChatModel chat = ChatModel(
                            sender: AuthService.authService
                                .getCurrentUser()!
                                .email!,
                            receiver: chatController.receiverEmail.value,
                            message: chatController.txtMessage.text,
                            time: Timestamp.now());

                        await CloudFireStoreService.cloudFireStoreService
                            .addChatInFireStore(chat);
                      },
                      icon: Icon(Icons.send))),
            )
          ],
        ),
      ),
    );
  }
}
