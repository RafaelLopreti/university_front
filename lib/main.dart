import 'package:flutter/material.dart';
import 'package:university_front/pages/home_page.dart';
import 'package:university_front/pages/login_page.dart';
import 'package:university_front/pages/profile_page.dart';
import 'package:university_front/services/notify_service.dart';
import 'package:university_front/services/prefs_service.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/profile': (context) => const ProfilePage()
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PrefsService.isAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          if (snapshot.data!) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }
          return Container();
        } else {
          return const Center(child: Text('Erro ao verificar autenticação'));
        }
      },
    );
  }
}
