import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/bottom_navigation_controller.dart';

var bottomNavigator = Get.put(BottomNavigator());

class BottomNavigationbar extends StatelessWidget {
  const BottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => bottomNavigator.screensList[bottomNavigator.index.value],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF075E54), // WhatsApp green color
        height: 60,
        items: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.message, color: Colors.white),
              Text(
                'Chats',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.update_sharp, color: Colors.white),
              Text(
                'Status',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.call, color: Colors.white),
              Text(
                'Calls',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),

        ],
        onTap: (index) {
          bottomNavigator.changeIndex(index);
        },
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
      ),
    );
  }
}
