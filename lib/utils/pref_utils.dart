//ignore: unused_import    
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static const _KeyIsFirstTime = 'isFirstTime';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _KeyLangue = 'langue';
  static const _KeyTheme = 'theme';
  static const _KeyUserId = 'userId';
  static const _KeyLastname = 'lastName';
  static const _KeyIsBoarding = 'isBoarding';
  static const _KeyObject = 'object';

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'dark';
    }
  }

  /*String getThemeData() {
    try {
      // Check if the 'themeData' key is present
      if (_sharedPreferences!.containsKey('themeData')) {
        // If yes, return the stored value
        return _sharedPreferences!.getString('themeData')!;
      } else {
        // If not, set the default value ('dark') and return it
         setThemeData('dark');
        return 'dark';
      }
    } catch (e) {
      return 'dark';
    }
  } */


  static Future setLangue(String lang) async =>
      await _sharedPreferences!.setString(_KeyLangue, lang);

  static String? getLangue() {
    try {
      return _sharedPreferences?.getString(_KeyLangue) ?? 'fr'; // Provide a default value
    } catch (e) {
      return 'fr';
    }
  }
  //static String? getLangue() => _sharedPreferences!.getString(_KeyLangue);

  static Future setTheme(String lang) async =>
      await _sharedPreferences!.setString(_KeyTheme, lang);

  static String? getTheme() => _sharedPreferences!.getString(_KeyTheme);

  ///Token
  static Future setIsFirstTime(bool token) async =>
      await _sharedPreferences!.setBool(_KeyIsFirstTime, token);

  static String? getIsFirstTime() => _sharedPreferences!.getString(_KeyIsFirstTime);

  static Future<void> clearIsFirstTime() async {
    await _sharedPreferences!.remove(_KeyIsFirstTime);
  }

  ///Email
  static Future setEmail(String username) async =>
      await _sharedPreferences!.setString(_keyEmail, username);

  static String? getEmail() => _sharedPreferences!.getString(_keyEmail);

  static Future<void> clearEmail() async {
    await _sharedPreferences!.remove(_keyEmail);
  }

  ///Password
  static Future setPassword(String password) async =>
      await _sharedPreferences!.setString(_keyPassword, password);

  static String? getPassword() => _sharedPreferences!.getString(_keyPassword);

  static Future<void> clearPassword() async {
    await _sharedPreferences!.remove(_keyPassword);
  }

  ///User Id
  static Future setUserId(String firstName) async =>
      await _sharedPreferences!.setString(_KeyUserId, firstName);

  static String? getUserId() => _sharedPreferences!.getString(_KeyUserId);

  static Future<void> clearUserId() async {
    await _sharedPreferences!.remove(_KeyUserId);
  }

  ///LastName
  static Future setLastName(String lastName) async =>
      await _sharedPreferences!.setString(_KeyLastname, lastName);

  static String? getLastName() => _sharedPreferences!.getString(_KeyLastname);

  static Future<void> clearLastName() async {
    await _sharedPreferences!.remove(_KeyLastname);
  }

  ///Is Boarding
  static Future setIsBoarding(String numIdentity) async =>
      await _sharedPreferences!.setString(_KeyIsBoarding, numIdentity);

  static String? getIsBoarding() => _sharedPreferences!.getString(_KeyIsBoarding);

  static Future<void> clearIsBoarding() async {
    await _sharedPreferences!.remove(_KeyIsBoarding);
  }

  ///Object
  static Future<void> setObject<T>(String value) async =>
      await _sharedPreferences!.setString(_KeyObject, value);

  static Object? getObject<T>() => _sharedPreferences!.get(_KeyObject);

  static Future<void> clearObject() async {
    await _sharedPreferences!.remove(_KeyObject);
  }
}
    