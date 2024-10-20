
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helpers/app_routes.dart';
import '../../../../../models/active_user_model.dart';
import '../../../../component/image/common_image.dart';

Widget activeUser(ActiveUserModel item) {
  return GestureDetector(
    onTap: () => Get.toNamed(AppRoutes.message, parameters: {
      "chatId": item.id,
      "name": item.userFullName,
      "image": item.image,
      // "image": item.image,
    }),
    child: Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Stack(
        children: [
          CommonImage(
            imageSrc: item.image,
            imageType: ImageType.png,
            height: 60,
            width: 60,
          ),
          Positioned(
              right: 0,
              top: 4,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50.r)),
              )),
        ],
      ),
    ),
  );
}
