
import 'package:get/get.dart';

import 'constants/app_colors.dart';

class Utils {
  static successSnackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: AppColors.white,
        backgroundColor: AppColors.black,
        snackPosition: SnackPosition.BOTTOM);
  }

  static errorSnackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: AppColors.white,
        backgroundColor: AppColors.red,
        snackPosition: SnackPosition.TOP);
  }
}
