import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/api_end_point.dart';

enum ImageType { png, svg, network }

class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double height;
  final double width;
  final double borderRadius;
  final double? size;
  final ImageType imageType;
  final BoxFit fill;

  CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height = 24,
    this.borderRadius = 0,
    this.width = 24,
    this.size,
    this.imageType = ImageType.svg,
    this.fill = BoxFit.fill,
    this.defaultImage = AppImages.noImage,
    super.key,
  });

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        imageSrc,
        // ignore: deprecated_member_use
        color: imageColor,
        height: size?.sp ?? height.h,
        width: size?.sp ?? width.w,
        fit: fill,
      );
    }

    if (imageType == ImageType.png) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          imageSrc,
          color: imageColor,
          height: size?.sp ?? height.h,
          width: size?.sp ?? width.w,
          fit: fill,
          errorBuilder: (context, error, stackTrace) {
            if (kDebugMode) {
              print("imageError : $error");
            }
            return Image.asset(defaultImage);
          },
        ),
      );
    }

    if (imageType == ImageType.network) {
      imageWidget = CachedNetworkImage(
        height: size?.sp ?? height.h,
        width: size?.sp ?? width.w,
        imageUrl: "${ApiEndPoint.imageUrl}/$imageSrc",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) {
          if (kDebugMode) {
            print(error);
          }
          return Image.asset(
            defaultImage,
          );
        },
      );
    }

    return SizedBox(
        height: size?.sp ?? height.h,
        width: size?.sp ?? width.w,
        child: imageWidget);
  }
}
