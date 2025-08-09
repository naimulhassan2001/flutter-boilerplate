import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_untitled/component/button/common_button.dart';
import 'package:new_untitled/component/image/common_image.dart';
import 'package:new_untitled/component/text/common_text.dart';
import 'package:new_untitled/config/route/app_routes.dart';
import 'package:new_untitled/utils/constants/app_colors.dart';
import 'package:new_untitled/utils/constants/app_images.dart';
import 'package:new_untitled/utils/constants/app_string.dart';
import 'package:new_untitled/utils/extensions/extension.dart';

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            112.height,
            CommonImage(imageSrc: AppImages.logo, height: 74, width: 158),
            CommonText(
              text: AppString.onboarding5,
              maxLines: 6,
              fontWeight: FontWeight.w400,
              color: AppColors.black_400,
            ),

            37.height,
            CommonButton(
              titleText: AppString.logIn,
              onTap: () => Get.toNamed(AppRoutes.signIn),
            ),
            16.height,
            CommonButton(
              titleText: AppString.signUp,
              buttonColor: AppColors.background,
              borderColor: AppColors.black,
              titleColor: AppColors.black_400,
              titleSize: 18,
              onTap: () => Get.toNamed(AppRoutes.signUp),
            ),

            35.height,
            Text(
              AppString.continueAsGuest,
              style: GoogleFonts.poppins(
                color: AppColors.violet_700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.violet_700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
