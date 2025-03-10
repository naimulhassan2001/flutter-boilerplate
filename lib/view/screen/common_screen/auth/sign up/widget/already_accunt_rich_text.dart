import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../../../config/route/app_routes.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/extensions/my_extension.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({
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
                  text: AppString.alreadyHaveAccount,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: AppString.signIn,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(AppRoutes.signIn);
                    },
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.primaryColor,
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
