import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_snackbar.dart';

class SettingController extends GetxController {
  /// Password input

  bool isLoading = false;
  final TextEditingController passwordController = TextEditingController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Delete account
  Future<void> deleteAccount() async {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      AppSnackbar.error(title: 'Error', message: 'Password required');
      return;
    }

    return;
    try {
      _setLoading(true);

      final body = {'password': password};

      final response = await ApiService.delete(ApiEndPoint.user, body: body);

      if (response.statusCode != 200) {
        throw Exception(response.message);
      }

      passwordController.clear();
      Get.offAllNamed(AppRoutes.signIn);
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Dispose controller
  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
