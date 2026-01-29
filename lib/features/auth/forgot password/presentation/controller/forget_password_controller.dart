import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../utils/app_snackbar.dart';

class ForgetPasswordController extends GetxController {
  /// Loading for forget password
  bool isLoadingEmail = false;

  /// Loading for Verify OTP

  bool isLoadingVerify = false;

  /// Loading for Creating New Password
  bool isLoadingReset = false;

  /// this is ForgetPassword Token , need to verification
  String forgetPasswordToken = '';

  /// this is timer , help to resend OTP send time
  int start = 0;
  Timer? _timer;
  String time = '00:00';

  /// here all Text Editing Controller
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'user@gmail.com' : '',
  );
  TextEditingController otpController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );

  /// create Forget Password Controller instance
  static ForgetPasswordController get instance =>
      Get.find<ForgetPasswordController>();

  @override
  void dispose() {
    startTimer();
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    time = '00:00';
    start = 0;
    _timer?.cancel();
    super.dispose();
  }

  /// start Time for check Resend OTP Time

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = '$minutes:$seconds';

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  /// Forget Password Api Call

  Future<void> forgotPasswordRepo() async {
    Get.toNamed(AppRoutes.verifyEmail);
    return;
    isLoadingEmail = true;
    update();

    final Map<String, String> body = {'email': emailController.text};
    final response = await ApiService.post(
      ApiEndPoint.forgotPassword,
      body: body,
    );

    if (response.statusCode == 200) {
      AppSnackbar.success(
        title: response.statusCode.toString(),
        message: response.message,
      );
      Get.toNamed(AppRoutes.verifyEmail);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoadingEmail = false;
    update();
  }

  /// Verify OTP Api Call

  Future<void> verifyOtpRepo() async {
    Get.toNamed(AppRoutes.createPassword);
    return;
    isLoadingVerify = true;
    update();
    final Map<String, String> body = {
      'email': emailController.text,
      'otp': otpController.text,
    };
    final response = await ApiService.post(ApiEndPoint.verifyOtp, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = response.data['data'] ?? {};
      forgetPasswordToken = data?['forgetPasswordToken'] ?? '';
      Get.toNamed(AppRoutes.createPassword);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoadingVerify = false;
    update();
  }

  /// Create New Password Api Call

  Future<void> resetPasswordRepo() async {
    Get.offAllNamed(AppRoutes.signIn);
    return;
    isLoadingReset = true;
    update();
    final Map<String, String> header = {
      'Forget-password': 'Forget-password $forgetPasswordToken',
    };

    final Map<String, String> body = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    final response = await ApiService.post(
      ApiEndPoint.resetPassword,
      body: body,
      headers: header,
    );

    if (response.statusCode == 200) {
      AppSnackbar.success(
        title: response.statusCode.toString(),
        message: response.message,
      );
      Get.offAllNamed(AppRoutes.signIn);

      emailController.clear();
      otpController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoadingReset = false;
    update();
  }
}
