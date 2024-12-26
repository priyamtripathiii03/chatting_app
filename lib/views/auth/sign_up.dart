import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/cloud_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 4),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: controller.txtName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller.txtPhone,
                        decoration: InputDecoration(
                          labelText: 'phone',
                          hintText: 'Enter your phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller.txtEmail,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller.txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller.txtConfirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your Confirm password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TextButton(
                          onPressed: () {},
                          child: const Text('Already have Account? Sign Up')),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if(controller.txtPassword.text==controller.txtConfirmPassword.text)
                            {
                              await AuthService.authService
                                  .createAccountWithEmailAndPassword(
                                  controller.txtEmail.text,
                                  controller.txtPassword.text);
                              UserModel user =UserModel(name: controller.txtName.text, email: controller.txtEmail.text, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIf4R5qPKHPNMyAqV-FjS_OTBB8pfUV29Phg&s", phone: controller.txtPhone.text, token: "----");
                              CloudFireStoreService.cloudFireStoreService.insertUserIntroFireStore(user);
                              Get.back();
                              controller.txtEmail.clear();
                              controller.txtPassword.clear();
                              controller.txtConfirmPassword.clear();
                              controller.txtName.clear();
                              controller.txtPhone.clear();
                            }


                          },
                          child: const Text('Sign Up'))
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
