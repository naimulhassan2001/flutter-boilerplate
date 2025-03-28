import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/api/api_service.dart';
import '../../../utils/constants/api_end_point.dart';
import '../../../utils/app_utils.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePasswordRepo() async {
    Get.back();
    return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "oldPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text
    };
    var response =
        await ApiService.patch(ApiEndPoint.changePassword, body: body);

    if (response.statusCode == 200) {
      Utils.successSnackBar(response.statusCode.toString(),response.message);

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      Get.back();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}
