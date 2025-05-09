
import 'package:campus_connects/constants/app_export.dart';

class S1 {
  Future<void> saveID({required String key, required String value}) async {
    final SharedPreferences sharePreference = await SharedPreferences.getInstance();
    try {
      await sharePreference.setString(key, value);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getSaveID({required String key}) async {
    final SharedPreferences sharePreference = await SharedPreferences.getInstance();
    return sharePreference.getString(key).toString();
  }

  Future<void> saveLogin({required String key, required bool value}) async {
    final SharedPreferences sharePreference = await SharedPreferences.getInstance();
    try {
      await sharePreference.setBool(key, value);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> getSaveLogin({required String key}) async {
    final SharedPreferences sharePreference = await SharedPreferences.getInstance();
    return sharePreference.getBool(key);
  }
}
