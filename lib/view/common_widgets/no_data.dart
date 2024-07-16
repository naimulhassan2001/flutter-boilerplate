import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_images.dart';
import '../../utils/app_string.dart';
import 'image/custom_image.dart';
import 'text/custom_text.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            imageSrc: AppImages.noData,
            imageType: ImageType.png,
            height: 70.sp,
            width: 70.sp,
          ),
          CustomText(
            text: AppString.noData,
            fontSize: 16.h,
            top: 8.h,
          )
        ],
      ),
    );
  }
}

class AppStrings {}
