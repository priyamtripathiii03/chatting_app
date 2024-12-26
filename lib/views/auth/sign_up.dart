import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/services/aut_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: controller.txtEmail,decoration: const InputDecoration(labelText: 'Email'),),
            TextField(controller: controller.txtPassword,decoration: const InputDecoration(labelText: 'Password'),),
            const SizedBox(height: 20,),
            TextButton(onPressed: (){

            }, child: const Text('Already have Account? Sign Up')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AuthService.authService.createAccountWithEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);

              Get.back();


              controller.txtEmail.clear();
              controller.txtPassword.clear();

            }, child: const Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
