import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_services.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Sign in Api call here
  Future<void> signInUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      Get.toNamed(AppRoutes.profile);
      return;

      final Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      final response = await ApiService.post(ApiEndPoint.signIn, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? '';
        LocalStorage.saveToken(data['accessToken'] ?? '');
        LocalStorage.saveRefreshToken(data['refreshToken'] ?? '');
        LocalStorage.saveUser(data['user'] ?? '');

        /// clear
        emailController.clear();
        passwordController.clear();

        /// navigate
        Get.offAllNamed(AppRoutes.profile);
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
        );
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      /// ALWAYS executed
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
