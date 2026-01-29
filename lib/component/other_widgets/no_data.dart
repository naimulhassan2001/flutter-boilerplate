import 'package:flutter/material.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_string.dart';
import '../image/common_image.dart';
import '../text/common_text.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          CommonImage(imageSrc: AppImages.noData, size: 70),
          CommonText(text: AppString.dataEmpty, fontSize: 16, top: 8),
        ],
      ),
    );
  }
}
