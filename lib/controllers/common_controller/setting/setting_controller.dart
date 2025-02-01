import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/route/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../core/api_end_point/app_url.dart';
import '../../../utils/app_utils.dart';



class SettingController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  deleteAccountRepo() async {
    isLoading = true;
    update();

    var body = {"password": passwordController.text};

    var response = await ApiService.deleteApi(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}