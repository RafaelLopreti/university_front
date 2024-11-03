import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:university_front/components/login_methods.dart';
import 'package:university_front/components/my_button.dart';
import 'package:university_front/components/my_textfield.dart';
import 'package:university_front/controllers/login_controller.dart';
import 'package:university_front/controllers/register_controller.dart';
import 'package:university_front/pages/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  final String? password;

  LoginPage({super.key, this.email, this.password});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final recoverEmailController = TextEditingController();

  bool isLoginMode = true;

  @override
  void initState() {
    super.initState();
    if (widget.email != null && widget.password != null) {
      emailController.text = widget.email!;
      passwordController.text = widget.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 65),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 225,
                    height: 225,
                    child: Lottie.asset('assets/lottie/login-animated.json'),
                  ),
                ),
                Text(
                  isLoginMode
                      ? 'Welcome back you\'ve been missed!'
                      : 'It\'s a pleasure to welcome you!',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
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
                if (!isLoginMode)
                  MyTextField(
                    keyboardType: TextInputType.text,
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    isConfidential: true,
                  ),
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
                            return ForgotPasswordPage(
                                recoverEmailController: recoverEmailController);
                          },
                        );
                      },
                      child: Text(
                        isLoginMode ? 'Forgot password?' : '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isLoginMode ? 25 : 0),
                Button(
                  text: isLoginMode ? 'Sign In' : 'Sign Up',
                  onTap: () {
                    if (isLoginMode) {
                      LoginController.login(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    } else {
                      RegisterController.register(
                        context,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
                const LoginMethods(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLoginMode ? 'Not a member?' : 'Already a member?',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoginMode = !isLoginMode;
                          if (isLoginMode) {
                            emailController.text = widget.email ?? '';
                            passwordController.text = widget.password ?? '';
                          } else {
                            emailController.clear();
                            passwordController.clear();
                          }
                        });
                      },
                      child: Text(
                        isLoginMode ? 'Register now' : 'Login',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
    );
  }
}
