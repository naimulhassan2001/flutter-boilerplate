import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';

class AppbarIcon extends StatelessWidget {
  const AppbarIcon({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: CircleAvatar(
          backgroundColor: AppColors.white50,
          child: ClipOval(child: InkWell(
              child: GestureDetector(
                onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back))))),
    );
  }
}
