import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../../helpers/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../helpers/app_routes.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppString.doNotHaveAccount,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: AppString.signUp,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "".tr,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          30.height
        ],
      ),
    );
  }
}
