import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_front/pages/login_page.dart';
import 'package:university_front/services/notify_service.dart';
import 'package:university_front/services/recovery_service.dart';
import 'dart:math';

class RecoveryController {
  static final RecoveryService recoveryService = RecoveryService();
  static late BuildContext _context;

  static Future<String> consult(BuildContext context, String email) async {
    _context = context;

    if (email.isEmpty) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.info,
        title: 'INFO',
        text: 'Email must not be empty.',
        confirmBtnText: 'OK',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
      throw Exception('Email is empty');
    }

    return await recoveryService.consult(email);
  }

  Future<void> updateUser(
      BuildContext context, TextEditingController newPassword, TextEditingController confirmPassword) async {
    _context = context;

    if (newPassword.text.isEmpty || confirmPassword.text.isEmpty) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.error,
        title: 'ERROR',
        text: 'Passwords cannot be empty.',
        confirmBtnText: 'RETRY',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
    } else if (newPassword.text != confirmPassword.text) {
      QuickAlert.show(
        context: _context,
        type: QuickAlertType.error,
        title: 'ERROR',
        text: 'The passwords don\'t match. ',
        confirmBtnText: 'RETRY',
        confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      );
    } else {
      return recoveryService.updateUser({'password': newPassword.text});
    }
  }

  static String success() {
    String code = (100000 + Random().nextInt(900000)).toString();
    NotificationService().showNotification(
      title: 'University',
      body: 'Code: $code',
    );
    return code;
  }

  static void failure(String text) {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.error,
      title: 'ERROR',
      text: text,
      confirmBtnText: 'RETRY',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
    );
  }

  static void successUpdate(String email, String password) {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.success,
      title: 'SUCCESS',
      text: 'Changed password, log in.',
      confirmBtnText: 'LOGIN',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
      onConfirmBtnTap: () {
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => LoginPage(email: email, password: password)),
        );
      },
    );
  }
}
