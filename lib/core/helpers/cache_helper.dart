import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Initialize SharedPreferences (call in main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---------------- Save ----------------
  Future<void> saveData({
    required String key,
    required dynamic value,
    bool secure = false,
  }) async {
    if (secure) {
      await _secureStorage.write(key: key, value: value.toString());
    } else {
      if (value is String) await _prefs!.setString(key, value);
      if (value is int) await _prefs!.setInt(key, value);
      if (value is bool) await _prefs!.setBool(key, value);
      if (value is double) await _prefs!.setDouble(key, value);
    }
  }

  // ---------------- Get ----------------
  Future<dynamic> getData(String key, {bool secure = false}) async {
    if (secure) {
      return await _secureStorage.read(key: key);
    } else {
      return _prefs!.get(key);
    }
  }

  // ---------------- Remove ----------------
  Future<void> removeData(String key, {bool secure = false}) async {
    if (secure) {
      await _secureStorage.delete(key: key);
    } else {
      await _prefs!.remove(key);
    }
  }

  // ---------------- Clear ----------------
  Future<void> clearAll({bool? secure}) async {
    if (secure == true) {
      // clear only secure
      await _secureStorage.deleteAll();
    } else if (secure == false) {
      // clear only prefs
      await _prefs!.clear();
    } else {
      // clear both
      await _secureStorage.deleteAll();
      await _prefs!.clear();
    }
  }
}
