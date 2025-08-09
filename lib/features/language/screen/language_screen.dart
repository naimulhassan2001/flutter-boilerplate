import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_untitled/component/button/common_button.dart';
import 'package:new_untitled/component/image/common_image.dart';
import 'package:new_untitled/component/text/common_text.dart';
import 'package:new_untitled/utils/constants/app_colors.dart';
import 'package:new_untitled/utils/constants/app_images.dart';
import 'package:new_untitled/utils/constants/app_string.dart';
import 'package:new_untitled/utils/extensions/extension.dart';

import '../../../config/route/app_routes.dart';
import '../../onboarding_screen/widgets/indicatior.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    super.key,
    required this.currentIndex,
    required this.controller,
  });

  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CommonText(
                text: AppString.usedToSupportCareInYourPreferredSpokenLanguage,
                maxLines: 2,
                fontSize: 12,
                top: 36,
                bottom: 18,
                color: AppColors.black_300,
              ),
              CommonImage(imageSrc: AppImages.language).center,

              CommonButton(
                titleText: AppString.german,
                buttonColor: AppColors.background,
                borderColor: AppColors.black,
                titleColor: AppColors.black_400,
              ),
              12.height,
              CommonButton(titleText: AppString.english),
              12.height,
              CommonButton(
                titleText: AppString.franc,
                buttonColor: AppColors.background,
                borderColor: AppColors.black,
                titleColor: AppColors.black_400,
              ),
              56.height,
              indicator(currentIndex),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(bottom: 62.h, left: 20.w, right: 20.w),
        child: CommonButton(
          onTap:
              () => controller.nextPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              ),
          titleText: AppString.continu,
        ),
      ),
    );
  }
}
