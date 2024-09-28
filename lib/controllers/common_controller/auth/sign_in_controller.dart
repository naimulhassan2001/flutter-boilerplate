import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../helpers/app_routes.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';

class SignInController extends GetxController {
  bool isLoading = false;

  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? 'developernaimul00@gmail.com' : '');
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? 'hello123' : "");

  Future<void> signInUser() async {
    Get.toNamed(AppRoutes.profile);
    return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.postApi(
      AppUrls.signIn,
      body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      PrefsHelper.token = data['data']["accessToken"];
      PrefsHelper.userId = data['data']["attributes"]["_id"];
      PrefsHelper.myImage = data['data']["attributes"]["image"];
      PrefsHelper.myName = data['data']["attributes"]["fullName"];
      PrefsHelper.myRole = data['data']["attributes"]["role"];
      PrefsHelper.myEmail = data['data']["attributes"]["email"];
      PrefsHelper.isLogIn = true;

      PrefsHelper.setString('token', PrefsHelper.token);
      PrefsHelper.setString("userId", PrefsHelper.userId);
      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setString("myName", PrefsHelper.myName);
      PrefsHelper.setString("myEmail", PrefsHelper.myEmail);
      PrefsHelper.setString("myRole", PrefsHelper.myRole);
      PrefsHelper.setBool("isLogIn", PrefsHelper.isLogIn);

      // if (PrefsHelper.myRole == 'consultant') {
      //   Get.offAllNamed(AppRoutes.doctorHome);
      // } else {
      //   Get.offAllNamed(AppRoutes.patientsHome);
      // }

      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
