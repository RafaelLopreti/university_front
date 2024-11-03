import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:university_front/components/square_tile.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key});

  static Future googleLogin() async {
    await GoogleSignInApi.login();
  }

  static void appleLogin() {
    print('Login via Apple');
    // Implementar a lógica de login via Apple aqui
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[500],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Or continue with',
                    style: TextStyle(color: Colors.black)),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                LoginMethods.googleLogin();
              },
              child: const SquareTile(
                imagePath: 'assets/images/google_logo.png',
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                LoginMethods.appleLogin();
              },
              child: const SquareTile(
                imagePath: 'assets/images/apple_logo.png',
              ),
            ),
          ],
        ),
      ],
    );
  }
}