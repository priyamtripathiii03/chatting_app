import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/home/call_page.dart';
import '../views/home/chat_page.dart';
import '../views/home/home_page.dart';
import '../views/home/status_page.dart';

class BottomNavigator extends GetxController {
  RxList<Widget> screensList = <Widget>[
    const HomePage(),
    const StatusPage(),
    const CallPage(),
  ].obs;
  RxInt index = 0.obs;

  void changeIndex(int value) {
    index.value = value;
  }
}
