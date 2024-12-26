import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  TextEditingController txtMessage = TextEditingController();

  void getReceiver(String email, String name)
  {
    receiverName.value = name;
    receiverEmail.value = email;
  }
}