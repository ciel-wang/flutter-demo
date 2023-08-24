import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKey {
  userName, // 用户名
  passWord, // 密码
  isRememb, // 是否记住密码
  serverIp, // 服务器地址
  port, // 端口号
  enableAppointment, // 是否启用预约
  enableFace, // 是否启用人证对比
  enableFaceVerify, // 是否启用人脸验证
  token, // token
}

extension SharedKeyExtension on SharedKey {
  String get value {
    switch (this) {
      case SharedKey.userName:
        return 'userName';
      case SharedKey.passWord:
        return 'passWord';
      case SharedKey.isRememb:
        return 'isRememb';
      case SharedKey.serverIp:
        return 'serverIp';
      case SharedKey.port:
        return 'port';
      case SharedKey.enableAppointment:
        return 'enableAppointment';
      case SharedKey.enableFace:
        return 'enableFace';
      case SharedKey.enableFaceVerify:
        return 'enableFaceVerify';
      case SharedKey.token:
        return 'token';
      default:
        throw Exception('Invalid key');
    }
  }

  static List<String> getValues() {
    return [
      SharedKey.userName.value,
      SharedKey.passWord.value,
      SharedKey.isRememb.value,
      SharedKey.serverIp.value,
      SharedKey.port.value,
      SharedKey.enableAppointment.value,
      SharedKey.enableFace.value,
      SharedKey.enableFaceVerify.value,
      SharedKey.token.value,
    ];
  }
}

class SharedData {
  static late SharedPreferences _prefs;
  static Future<String> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    return 'ok';
  }

  static void save(Map item) {
    List<String> validKeys = SharedKeyExtension.getValues();
    item.forEach((key, value) {
      if (key is String && validKeys.contains(key)) {
        switch (value.runtimeType) {
          case String:
            _prefs.setString(key, value);
            break;
          case int:
            _prefs.setInt(key, value);
            break;
          case double:
            _prefs.setDouble(key, value);
            break;
          case bool:
            _prefs.setBool(key, value);
            break;
          case List:
            _prefs.setStringList(key, value.cast<String>());
            break;
        }
      }
    });
  }

  static void saveString(SharedKey key, String value) {
    _prefs.setString(key.value, value);
  }

  static String? getString(SharedKey key) {
    return _prefs.getString(key.value);
  }

  static void saveBool(SharedKey key, bool value) {
    _prefs.setBool(key.value, value);
  }

  static bool? getBool(SharedKey key) {
    return _prefs.getBool(key.value);
  }

  static void saveInt(SharedKey key, int value) {
    _prefs.setInt(key.value, value);
  }

  static int? getInt(SharedKey key) {
    return _prefs.getInt(key.value);
  }

  static void saveDouble(SharedKey key, double value) {
    _prefs.setDouble(key.value, value);
  }

  static double? getDouble(SharedKey key) {
    return _prefs.getDouble(key.value);
  }

  static void saveList(SharedKey key, List<String> value) {
    _prefs.setStringList(key.value, value);
  }

  static List? getList(SharedKey key) {
    return _prefs.getStringList(key.value);
  }

  static void removeKey(SharedKey key) {
    _prefs.remove(key.value);
  }

  static void clearKey() {
    _prefs.clear();
  }
}
