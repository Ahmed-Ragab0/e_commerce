import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required key,
    required value,
  }) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    return await sharedPreferences!.setInt(key, value);
  }

  static dynamic getData({
    required key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({key}) async {
    return await sharedPreferences!.remove(key);
  }
}
