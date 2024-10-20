import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/my_extension.dart';
import '../../../../../models/chat_list_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';

Widget chatListItem({required Chat item}) {
  return Container(
    padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
    decoration: const BoxDecoration(color: AppColors.transparent),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 35.sp,
              child: ClipOval(
                child: CommonImage(
                  imageSrc: item.participant.image,
                  imageType: ImageType.network,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            12.width,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: item.participant.fullName,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                CommonText(
                  text: item.latestMessage.message,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ))
          ],
        ),
        16.height,
        const Divider(
          height: 1,
        )
      ],
    ),
  );
}
