import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/setting/setting_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../common_widgets/bottom_nav_bar/common_bottom_bar.dart';
import '../../../common_widgets/pop_up/common_pop_menu.dart';
import '../../../common_widgets/text/common_text.dart';
import 'widget/setting_item.dart';
import '../../../../../extension/my_extension.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Settings".tr,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                70.height,
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                  child: SettingItem(
                    title: "Change Password".tr,
                    iconDate: Icons.lock_outline,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                  child: SettingItem(
                    title: "Terms of Services".tr,
                    iconDate: Icons.gavel,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  child: SettingItem(
                    title: "Privacy Policy".tr,
                    iconDate: Icons.network_wifi_1_bar,
                  ),
                ),
                GestureDetector(
                  onTap: () => deletePopUp(
                      controller: controller.passwordController,
                      onTap: controller.deleteAccountRepo,
                      isLoading: controller.isLoading),
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: AppColors.blueLight,
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.secondary,
                        ),
                        CommonText(
                          text: "Delete account".tr,
                          color: AppColors.secondary,
                          left: 12.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
