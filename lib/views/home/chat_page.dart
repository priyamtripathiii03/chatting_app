import 'package:chatting_app/model/chat_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:chatting_app/views/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      email: AuthService.authService.getCurrentUser()!.email.toString(),
      isOnline: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      email: AuthService.authService.getCurrentUser()!.email.toString(),
      isOnline: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatController.receiverName.value.toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF075E54),
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
                    reverse: false,
                    // Reverse the chat order so that new messages appear at the bottom
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      bool isSender = chatList[index].sender ==
                          AuthService.authService.getCurrentUser()!.email!;
                      return GestureDetector(
                        onLongPress: () {
                          if (isSender) {
                            chatController.txtUpdateMessage =
                                TextEditingController(
                                    text: chatList[index].message);
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
                            CloudFireStoreService.cloudFireStoreService
                                .removeChat(docIdList[index],
                                    chatController.receiverEmail.value);
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
                            child: Column(
                              children: [
                                Text(
                                  chatList[index].message,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '''${(chatList[index].time.toDate().hour > 12) ? (chatList[index].time.toDate().hour % 12).toString().padLeft(2, '0') : (chatList[index].time.toDate().hour).toString().padLeft(2, '0')} : ${chatList[index].time.toDate().minute.toString().padLeft(2, '0')}''',
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      (chatList[index].time.toDate().hour <= 12)
                                          ? ('AM')
                                          : ('PM'),
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                )
                              ],
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
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file)),
                      IconButton(
                        onPressed: () async {
                          if (chatController.txtMessage.text.isNotEmpty) {
                            ChatModel chat = ChatModel(
                              sender: AuthService.authService
                                  .getCurrentUser()!
                                  .email!,
                              receiver: chatController.receiverEmail.value,
                              message: chatController.txtMessage.text,
                              time: Timestamp.now(),
                            );
                            await CloudFireStoreService.cloudFireStoreService
                                .addChatInFireStore(chat);
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
