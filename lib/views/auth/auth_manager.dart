import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/views/auth/sign_in.dart';
import 'package:chatting_app/views/home/home_page.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser()==null)?const SignIn():const HomePage();
  }
}
