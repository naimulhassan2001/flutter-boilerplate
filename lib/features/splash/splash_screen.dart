import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_untitled/component/button/common_button.dart';
import 'package:new_untitled/component/text/common_text.dart';
import 'package:new_untitled/utils/constants/app_colors.dart';
import 'package:new_untitled/utils/constants/app_string.dart';
import 'package:new_untitled/utils/extensions/extension.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_images.dart';
import '../../component/image/common_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImage(imageSrc: AppImages.logo, height: 74, width: 158).center,
          CommonText(
            text: AppString.welcomeToEvioYourHealthyProxy,
            fontSize: 18,
            maxLines: 2,
            fontWeight: FontWeight.w500,
            color: AppColors.black_400,
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 62.h, left: 20.w, right: 20.w),
        child: CommonButton(
          onTap: () {
            // if (LocalStorage.isLogIn) {
            //   if (LocalStorage.myRole == 'consultant') {
            //     Get.offAllNamed(AppRoutes.doctorHome);
            //   } else {
            //     Get.offAllNamed(AppRoutes.patientsHome);
            //   }
            // } else {
            Get.offAllNamed(AppRoutes.onboarding);
          },
          titleText: AppString.getStarted,
        ),
      ),
    );
  }
}
