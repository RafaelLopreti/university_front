import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_front/services/notify_service.dart';
import 'package:university_front/services/recovery_service.dart';
import 'dart:math';

class RecoveryController {
  static late BuildContext _context;

  static consult(BuildContext context, String email) {
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
    } else {
      RecoveryService().consult(email);
    }
  }

  String generateRandomCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  static void success() {
    NotificationService().showNotification(
      title: 'University',
      body: 'Code: ${(100000 + Random().nextInt(900000)).toString()}',
    );
  }

  static void failure() {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.error,
      title: 'ERROR',
      text: 'Incorrect email.',
      confirmBtnText: 'OK',
      confirmBtnColor: const Color.fromARGB(255, 44, 111, 255),
    );
  }
}
