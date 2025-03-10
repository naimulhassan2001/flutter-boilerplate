import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/services/storage/storage_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/route/app_routes.dart';


class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences localStorage = await getMyStorage();
    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";

    if (kDebugMode) {
      print(userId);
    }
  }

  ///<<<======================== Get All Data Form Shared Preference ============>

  static Future<void> removeAllPrefData() async {
    SharedPreferences localStorage = await getMyStorage();
    await localStorage.clear();
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);

    Get.offAllNamed(AppRoutes.signIn);
    getAllPrefData();
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future setString(String key, value) async {
    SharedPreferences localStorage = await getMyStorage();
    return localStorage.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences localStorage = await getMyStorage();
    return localStorage.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences localStorage = await getMyStorage();
    return localStorage.setInt(key, value);
  }

  ///<<<======================== Create Local Storage Instance  ============>

  static SharedPreferences? preferences;

  static Future<SharedPreferences> getMyStorage() async {
    return preferences ?? await SharedPreferences.getInstance();
  }
}
