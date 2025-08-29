import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';

Widget indicator(int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      4,
      (index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        width: 20.w,
        height: 8.h,
        decoration: BoxDecoration(
          color: currentIndex == index ? AppColors.black : AppColors.black_100,
        ),
      ),
    ),
  );
}
