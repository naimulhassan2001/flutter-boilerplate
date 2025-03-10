import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/log/error_log.dart';
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

  const CommonImage({
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

  @override
  Widget build(BuildContext context) {
    final double finalHeight = size?.sp ?? height.h;
    final double finalWidth = size?.sp ?? width.w;

    switch (imageType) {
      case ImageType.svg:
        return SvgPicture.asset(
          imageSrc,
          color: imageColor,
          height: finalHeight,
          width: finalWidth,
          fit: fill,
        );

      case ImageType.png:
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            imageSrc,
            color: imageColor,
            height: finalHeight,
            width: finalWidth,
            fit: fill,
            errorBuilder: (context, error, stackTrace) {
              errorLog(error, source: "Common image");
              return Image.asset(defaultImage);
            },
          ),
        );

      case ImageType.network:
        return CachedNetworkImage(
          height: finalHeight,
          width: finalWidth,
          imageUrl: "${ApiEndPoint.imageUrl}/$imageSrc",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius.r),
              image: DecorationImage(
                image: imageProvider,
                fit: fill,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(
                child: CircularProgressIndicator(value: downloadProgress.progress),
              ),
          errorWidget: (context, url, error) {
            errorLog(error, source: "Common image");
            return Image.asset(defaultImage);
          },
        );
    }
  }
}
