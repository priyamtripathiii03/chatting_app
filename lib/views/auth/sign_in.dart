import 'package:chatting_app/controller/auth_controller.dart';
import 'package:chatting_app/services/auth_service.dart';
import 'package:chatting_app/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign In',
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
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String response = await AuthService.authService
                                .signInWithEmailAndPassword(
                                controller.txtEmail.text,
                                controller.txtPassword.text);
                            User? user =
                            AuthService.authService.getCurrentUser();
                            if (user != null && response == "Success") {
                              Get.offAndToNamed('/navigationBar');
                            } else {
                              Get.snackbar('Sign In Failed !', response);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('or'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SignInButton(Buttons.google, onPressed: (){
                          GoogleAuthService.googleAuthService.signInWithGoogle();
                          User? user = AuthService.authService.getCurrentUser();
                        }),
                      ],

                    ),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/signUp');
                        },
                        child: const Text(
                          '''Don't have account ? Sign Up''',
                          style: TextStyle(
                            letterSpacing: 0.5,
                          ),
                        )),
                  ]),
            ),
          )),
    );
  }
}