import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../common_widgets/button/common_button.dart';
import '../../../common_widgets/image/common_image.dart';
import '../../../../../extension/my_extension.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            180.height,
            Center(
                child: CommonImage(
              imageSrc: AppImages.noImage,
              height: 70,
              width: 70,
              imageType: ImageType.png,
            )),
            120.height,
            CommonButton(
              titleText: "Sign in with password".tr,
              onTap: () => Get.toNamed(AppRoutes.signIn),
            ),
            24.height,
            CommonButton(
              titleText: "Sign up".tr,
              onTap: () => Get.toNamed(AppRoutes.signUp),
            ),
          ],
        ),
      ),
    );
  }
}
