import 'package:dio/dio.dart';
import 'package:university_front/configs/urls_config.dart';
import 'package:university_front/controllers/recovery_controller.dart';

class RecoveryService {
  final Dio _dio = Dio();

  Future<void> consult(String email) async {
    try {
      Response response = await _dio.get(
        UrlsConfig.userByEmailUrl + email
      );

      if (response.statusCode == 200) {
        RecoveryController.success();
      } else {
        RecoveryController.failure();
      }
    } catch (e) {
      RecoveryController.failure();
    }
  }
}