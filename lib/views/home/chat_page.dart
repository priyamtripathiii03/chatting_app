import 'dart:io';
import 'package:chatting_app/model/chat_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:chatting_app/views/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      email: AuthService.authService.getCurrentUser()!.email.toString(),
      isOnline: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      email: AuthService.authService.getCurrentUser()!.email.toString(),
      isOnline: false,
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        labelText: 'Edit your message'),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        String docId = docIdList[index];
                                        CloudFireStoreService
                                            .cloudFireStoreService
                                            .updateChat(
                                          chatController.receiverEmail.value,
                                          chatController.txtUpdateMessage.text,
                                          docId,
                                        );
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
                                .removeChat(
                              docIdList[index],
                              chatController.receiverEmail.value,
                            );
                          }
                        },
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? Colors.teal[200]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatList[index].message,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(chatList[index].time.toDate().hour % 12).toString().padLeft(2, '0')}:${chatList[index].time.toDate().minute.toString().padLeft(2, '0')} ${(chatList[index].time.toDate().hour < 12) ? 'AM' : 'PM'}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
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

            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController.txtMessage,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.attach_file),
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () async {
                      if (chatController.txtMessage.text.isNotEmpty) {
                        ChatModel chat = ChatModel(
                          sender:
                          AuthService.authService.getCurrentUser()!.email!,
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
          ],
        ),
      ),
    );
  }
}