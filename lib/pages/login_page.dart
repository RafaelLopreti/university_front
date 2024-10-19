import 'package:flutter/material.dart';
import 'package:university_front/components/login_methods.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/controllers/login_controller.dart';
import 'package:university_front/pages/register_page.dart';
import 'package:university_front/pages/forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  final String? email;
  final String? password;
  final String? recoverEmail;

  LoginPage({super.key, this.email, this.password, this.recoverEmail}) {
    emailController.text = email ?? '';
    passwordController.text = password ?? '';
    recoverEmailController.text = recoverEmail ?? '';
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final recoverEmailController = TextEditingController();

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
                    'Welcome back you\'ve been missed!',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 25.0, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ForgotPasswordPage(recoverEmailController: recoverEmailController);
                            },
                          );
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SignButton(
                    text: 'Sign In',
                    onTap: () {
                      LoginController.login(
                        context,
                        emailController.text,
                        passwordController.text,
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
                        'Not a member?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.limeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
