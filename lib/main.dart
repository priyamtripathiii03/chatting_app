import 'package:chatting_app/views/auth/auth_manager.dart';
import 'package:chatting_app/views/auth/sign_in.dart';
import 'package:chatting_app/views/auth/sign_up.dart';
import 'package:chatting_app/views/home/bottom_navigationbar.dart';
import 'package:chatting_app/views/home/call_page.dart';
import 'package:chatting_app/views/home/chat_page.dart';
import 'package:chatting_app/views/home/contact_page.dart';
import 'package:chatting_app/views/home/home_page.dart';
import 'package:chatting_app/views/home/profile_page.dart';
import 'package:chatting_app/views/home/status_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const AuthManager(),
        ),
        GetPage(
          name: '/signIn',
          page: () => const SignIn(),
        ),
        GetPage(
          name: '/signUp',
          page: () => const SignUp(),
        ),
        GetPage(
          name: '/navigationBar',
          page: () => const BottomNavigationbar(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatPage(),
        ),
        GetPage(
          name: '/status',
          page: () => const StatusPage(),
        ),
        GetPage(
          name: '/call',
          page: () => const CallPage(),
        ),
      ],
    );
  }
}
