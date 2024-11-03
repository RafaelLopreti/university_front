import 'package:dio/dio.dart';
import 'package:university_front/configs/urls_config.dart';
import 'package:university_front/controllers/recovery_controller.dart';

class RecoveryService {
  final Dio _dio = Dio();
  String userId = "";
  String userEmail = "";

  Future<String> consult(String email) async {
    try {
      Response response = await _dio.get(
        UrlsConfig.userByEmailUrl + email,
      );

      if (response.statusCode == 200) {
        userId = response.data['id'].toString();
        userEmail = email;
        return RecoveryController.success();
      } else {
        RecoveryController.failure('Incorrect email.');
        throw Exception('Failed to recover e-mail not exists.');
      }
    } catch (e) {
      RecoveryController.failure('Contact the administrator.');
      rethrow;
    }
  }

  Future<void> updateUser(Map<String, String> data) async {
    try {
      Response response = await _dio.patch(
        "${UrlsConfig.userUrl}/$userId",
        queryParameters: data,
      );

      if (response.statusCode == 200) {
        RecoveryController.successUpdate(
            userEmail, data['password'].toString());
      } else {
        RecoveryController.failure('Error updating the password.');
      }
    } catch (e) {
      RecoveryController.failure('Contact the administrator.');
    }
  }
}
