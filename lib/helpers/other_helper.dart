import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class OtherHelper {
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? emailValidator(value, controller) {
    if (value!.isEmpty) {
      return "This field is required".tr;
    } else if (!emailRegexp.hasMatch(controller.emailController.text)) {
      return "Enter valid email".tr;
    } else {
      return null;
    }
  }

  static Future<void> dateOfBirthPicker(
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // <-- SEE HERE
              onPrimary: AppColors.white, // <-- SEE HERE
              onSurface: AppColors.black, // <-- SEE HERE
            ),
          ),
          child: child!),
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.year}/${picked.month}/${picked.day}";
    }
  }
}