import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_front/services/login_service.dart';

class LoginController {
  static late BuildContext _context;

  static void login(BuildContext context, String email, String password) {
    _context = context;

    if (email.isEmpty || password.isEmpty) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.error,
        title: 'ERROR',
        text: 'Email or password must not be empty.',
        confirmBtnText: 'OK',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
    } else {
      LoginService().login(email, password);
    }
  }

  static void success() {
    Navigator.pushReplacementNamed(
      _context,
      '/home',
    );
  }

  static void failure() {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.info,
      title: 'INFO',
      text: 'Incorrect email or password.',
      confirmBtnText: 'OK',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
    );
  }
}
