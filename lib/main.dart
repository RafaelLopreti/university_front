import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:university_front/services/notify_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  runApp(const University());
}

class University extends StatelessWidget {
  const University({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}