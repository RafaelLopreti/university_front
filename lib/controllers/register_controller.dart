import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_front/pages/login_page.dart';
import 'package:university_front/services/register_service.dart';

class RegisterController {
  static late BuildContext _context;

  static void register(BuildContext context, String email, String password,
      String confirmPassword) {
    _context = context;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.error,
        title: 'ERROR',
        text: 'Email or password must not be empty.',
        confirmBtnText: 'OK',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
    } else if (password != confirmPassword) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.error,
        title: 'ERROR',
        text: 'The passwords don\'t match.',
        confirmBtnText: 'RETRY',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
    } else {
      RegisterService().register(email, password);
    }
  }

  static void success(String email, String password) {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.success,
      title: 'SUCCESS',
      text: 'Registration completed, log in.',
      confirmBtnText: 'LOGIN',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      onConfirmBtnTap: () {
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage(email: email, password: password)),
        );
      },
    );
  }

  static void existsFailure() {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.info,
      title: 'INFO',
      text:
          'It looks like there is already an account associated with this email. Please log in.',
      confirmBtnText: 'RETRY',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
    );
  }

  static void genericFailure() {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.error,
      title: 'ERROR',
      text: 'An error has occurred, try again.',
      confirmBtnText: 'RETRY',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
    );
  }
}
