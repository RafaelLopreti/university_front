import 'package:dio/dio.dart';
import 'package:university_front/configs/urls_config.dart';
import 'package:university_front/controllers/login_controller.dart';
import 'package:university_front/services/prefs_service.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    try {
      Map<String, dynamic> loginData = {'email': email.toLowerCase(), 'password': password};

      Response response = await _dio.post(
        UrlsConfig.loginUrl,
        data: loginData,
      );

      if (response.statusCode == 200) {
        PrefsService.save(response.data);
        LoginController.success();
      } else {
        LoginController.failure();
      }
    } catch (e) {
      LoginController.failure();
    }
  }
}
