import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PrefsHelper extends GetxController {
  static String token = "";
  static bool isLogIn = false;
  static bool isNotifications = true;
  static String refreshToken = "";
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String mySubscription = "shopping";
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token") ?? "";
    refreshToken = preferences.getString("refreshToken") ?? "";
    userId = preferences.getString("userId") ?? "";
    myImage = preferences.getString("myImage") ?? "";
    myName = preferences.getString("myName") ?? "";
    myEmail = preferences.getString("myEmail") ?? "";
    myRole = preferences.getString("myRole") ?? "";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    isNotifications = preferences.getBool("isNotifications") ?? true;
    mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode =
        preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode =
        preferences.getString("localizationLanguageCode") ?? "en";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    isNotifications = preferences.getBool("isNotifications") ?? true;
    mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode = preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode = preferences.getString("localizationLanguageCode") ?? "en";


    if (kDebugMode) {
      print(userId);
    }
  }

  ///<<<======================== Get All Data Form Shared Preference ============>
  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setString("token", "");
    preferences.setString("refreshToken", "");
    preferences.setString("userId", "");
    preferences.setString("myImage", "");
    preferences.setString("myName", "");
    preferences.setString("myEmail", "");
    preferences.setBool("isLogIn", false);
    preferences.setBool("isNotifications", true);
    preferences.setString("mySubscription", "shopping");

    // Get.offAllNamed(AppRoutes.login);
    getAllPrefData();
  }

  ///<<<======================== Get Data Form Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  ///<<<==========================Remove Value==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
