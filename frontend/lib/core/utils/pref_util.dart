import 'dart:convert';

import 'package:frontend/features/auth/domain/entities/login_model.dart';
import 'package:frontend/features/auth/domain/entities/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  ///create instance
  SharedPrefsHelper._();

  static final SharedPrefsHelper _instance = SharedPrefsHelper._();

  factory SharedPrefsHelper() => _instance;

  //intialize shared preference
  static late SharedPreferences _sharedPreferences;

  static Future<SharedPrefsHelper> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _instance;
  }

  static const String _keyExample = 'example_key';

  // Save a string value
  static Future<bool> saveString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  // Get a string value
  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  // Save an integer value
  static Future<bool> saveInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  // Get an integer value
  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  // Save a boolean value
  static Future<bool> saveBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  // Get a boolean value
  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  // Save a double value
  static Future<bool> saveDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  // Get a double value
  static double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  // Save a list of strings
  static Future<bool> saveStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  // Get a list of strings
  static List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  // Remove a value
  static Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  // Clear all values
  static Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  static Future<bool> saveToken(LoginModel loginModel) async {
    return await saveString('token', jsonEncode(loginModel.toJson()));
  }

  static LoginModel? getToken() {
    return getString('token') != null
        ? LoginModel.fromJson(jsonDecode(getString('token')!))
        : null;
  }

  static Future<bool> setUser(UserModel userModel) async {
    return await saveString('user', jsonEncode(userModel.toJson()));
  }

  static UserModel? getUser() {
    return getString('user') != null
        ? UserModel.fromJson(jsonDecode(getString('user')!))
        : null;
  }
}
