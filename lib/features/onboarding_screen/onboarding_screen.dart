import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/extensions/extension.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';
import '../../component/image/common_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              180.height,

              /// Logo
              const CommonImage(imageSrc: AppImages.noImage, size: 90),
              120.height,

              /// Sign In
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.signIn),
                child: const Text(AppString.signIn),
              ),
              24.height,

              /// Sign Up
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.signUp),
                child: const Text(AppString.signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
