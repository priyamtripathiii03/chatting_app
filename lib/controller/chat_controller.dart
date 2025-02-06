

import 'dart:typed_data';

import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/store_api.dart';

class ChatController extends GetxController
{
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxString image = "".obs;
  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpdateMessage = TextEditingController();
  TextEditingController isFabHovered = TextEditingController();


  void getReceiver(String email, String name)
  {
    receiverName.value = name;
    receiverEmail.value = email;
  }
  void storeImage(String userImage) {
    image.value = userImage;
  }
  Future<void> imagePicker(UserModel user) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    Uint8List image = await xFile!.readAsBytes();
    user.image = await ApiHelper.apiHelper.imageUpload(image: image) ?? "";
    await CloudFireStoreService.cloudFireStoreService.insertUserIntroFireStore(user);
  }
}