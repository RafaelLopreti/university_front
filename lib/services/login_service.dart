import 'package:dio/dio.dart';
import 'package:university_front/configs/urls_config.dart';
import 'package:university_front/controllers/login_controller.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<void> login(String email, String password) async {
    try {
      Map<String, dynamic> loginData = {'email': email, 'password': password};

      Response response = await _dio.post(
        UrlsConfig.loginUrl,
        data: loginData,
      );

      if (response.statusCode == 200) {
        LoginController.success();
      } else {
        LoginController.failure();
      }
    } catch (e) {
      LoginController.failure();
    }
  }
}