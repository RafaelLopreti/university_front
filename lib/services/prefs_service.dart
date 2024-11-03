import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const String _key = 'key';

  static Future<void> save(Map<String, dynamic> userData) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({"userData": userData, "isAuth": true}));
  }

  static Future<void> updateProfileImage(String profileImageUrl) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var userData = jsonDecode(jsonResult);
      userData['userData']['profileImage'] = profileImageUrl;
      prefs.setString(_key, jsonEncode(userData));
    }
  }

  static Future<String?> getProfileImage() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var userData = jsonDecode(jsonResult);
      return userData['userData']['profileImage'];
    }
    return null;
  }

  static Future<String?> getFromData(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var userData = jsonDecode(jsonResult);
      return userData['userData'][key];
    }
    return null;
  }

  static Future<String?> getFromAddress(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var userData = jsonDecode(jsonResult);
      return userData['userData']['address'][key];
    }
    return null;
  }

  static Future<String?> getFromUser(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var userData = jsonDecode(jsonResult);
      return userData['userData']['user'][key];
    }
    return null;
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    return jsonResult != null ? jsonDecode(jsonResult)['isAuth'] : false;
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}
