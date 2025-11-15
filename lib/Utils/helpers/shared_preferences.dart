import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // SETTERS
  static Future<void> setStringPrefValue({required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static Future<void> setIntPrefValue({required String key, required int value}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  static Future<void> setBoolPrefValue({required String key, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> setMapPrefValue({required key, required Map<String, dynamic> value}) async {
    final prefs = await SharedPreferences.getInstance();

    String encodedMap = json.encode(value);
    await prefs.setString(key, encodedMap);
  }

  // GETTERS
  static Future<String?> getStringPrefValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> getIntPrefValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool?> getBoolPrefValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // REMOVAL
  static Future<dynamic> removeKeyData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // check if key exists
  static Future<dynamic> keyContains({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Function to remove all keys except the specified one
  static Future<void> removeAllKeysExcept({required List<String> keysToKeep}) async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys().toList();

    for (String key in allKeys) {
      if (!keysToKeep.contains(key)) {
        await prefs.remove(key);
      }
    }
  }
}
