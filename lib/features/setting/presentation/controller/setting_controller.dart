import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_snackbar.dart';

class SettingController extends GetxController {
  /// Password controller here , use for delete account
  TextEditingController passwordController = TextEditingController();

  /// loading check , use delete account
  bool isLoading = false;

  /// account delete api call here
  Future<void> deleteAccountRepo() async {
    isLoading = true;
    update();

    final body = {'password': passwordController.text};

    final response = await ApiService.delete(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      AppSnackbar.error(
        title: response.statusCode.toString(),
        message: response.message,
      );
    }
    isLoading = false;
    update();
  }
}
