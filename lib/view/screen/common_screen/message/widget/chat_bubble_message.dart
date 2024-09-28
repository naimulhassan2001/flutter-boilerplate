import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../helpers/my_extension.dart';
import '../../../../../utils/app_images.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';


class ChatBubbleMessage extends StatelessWidget {
  final DateTime time;
  final String text;
  final String image;
  final bool isMe;
  final bool isEmoji;
  final int index;
  final int messageIndex;
  final bool isCall;
  final bool isNotice;
  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    required this.onTap,
    this.isEmoji = false,
    this.index = 0,
    this.messageIndex = 1,
    this.isCall = false,
    this.isNotice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // //=======-============================Question====================================

          isCall
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //     backgroundColor: AppColors.white,
                    //     radius: 20.sp,
                    //     child: ClipOval(
                    //         child: Image.asset(
                    //       image,
                    //       width: 36.sp,
                    //       height: 36.sp,
                    //       fit: BoxFit.fill,
                    //     ))),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      padding: EdgeInsets.only(left: 10.w),
                      width: 220,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          CommonImage(
                            imageSrc: AppImages.noImage,
                            fill: BoxFit.contain,
                            height: 60,
                          ),
                          Container(
                            color: AppColors.primaryColor,
                            width: 220,
                            child: CommonText(
                              maxLines: 5,
                              text: text,
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : isNotice
                  ? Center(
                      child: CommonText(
                      text: text,
                      maxLines: 1,
                      top: 8,
                      bottom: 8,
                      fontWeight: FontWeight.w700,
                    ))
                  : Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMe == false && isCall == false)
                          CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 20,
                              child: ClipOval(
                                  child: CommonImage(
                                imageSrc: image,
                                width: 36,
                                height: 36,
                                imageType: ImageType.network,
                              ))),
                        const SizedBox(
                          width: 8,
                        ),
                        if (isCall == false)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onLongPress: () {
                                    onTap();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CommonText(
                                      maxLines: 10,
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w400,
                                      text: text,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                CommonText(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  text: time.time,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
