import 'package:dio/dio.dart';
import 'package:university_front/configs/urls_config.dart';
import 'package:university_front/controllers/register_controller.dart';

class RegisterService {
  final Dio _dio = Dio();

  Future<void> register(String email, String password) async {
    try {
      Map<String, dynamic> registerData = {
        'email': email,
        'password': password
      };

      Response response = await _dio.post(
        UrlsConfig.registerUrl,
        data: registerData,
      );

      if (response.statusCode == 201) {
        RegisterController.success(email, password);
      } else if (response.statusCode == 400 &&
          response.statusMessage != null &&
          response.statusMessage!.contains('already exists')) {
        RegisterController.existsFailure();
      }
    } catch (e) {
      RegisterController.genericFailure();
    }
  }
}
