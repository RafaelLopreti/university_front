import 'package:flutter/material.dart';
import 'package:university_front/components/login_methods.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/controllers/register_controller.dart';
import 'package:university_front/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 12, 76, 163),
              Color.fromRGBO(2, 46, 93, 1),
              Color.fromRGBO(1, 120, 239, 1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Image.asset(
                      'assets/images/matera_logo.jpg',
                      height: 72,
                    ),
                  ),
                  const Text(
                    'It\'s a pleasure to welcome you!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Email',
                    isConfidential: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    hintText: 'Password',
                    isConfidential: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    isConfidential: true,
                  ),
                  const SizedBox(height: 25),
                  SignButton(
                    text: 'Sign Up',
                    onTap: () {
                      RegisterController.register(
                        context,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  const LoginMethods(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.limeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
