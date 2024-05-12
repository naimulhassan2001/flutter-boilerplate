import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../utils/app_images.dart';

enum ImageType { png, svg, network, decorationImage }

class CustomImage extends StatefulWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final ImageType imageType;
  final BoxFit fill;

  CustomImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.width,
    this.imageType = ImageType.svg,
    this.fill = BoxFit.fill,
    this.defaultImage = AppImages.noImage,
    super.key,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  RxBool notNetworkError = true.obs;

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (widget.imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
        fit: widget.fill,
      );
    }

    if (widget.imageType == ImageType.png) {
      imageWidget = Image.asset(
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
        fit: widget.fill,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset(widget.defaultImage),
      );
    }

    if (widget.imageType == ImageType.network) {
      imageWidget = Image.network(
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
        fit: widget.fill,
        errorBuilder: (context, error, stackTrace) {
          print(widget.imageSrc);
          return Image.asset(widget.defaultImage);
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    if (widget.imageType == ImageType.decorationImage) {
      imageWidget = Obx(() => notNetworkError.value
          ? Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageSrc),
                    onError: (exception, stackTrace) {
                      if (kDebugMode) {
                        print("before: ${notNetworkError.value}");
                      }

                      notNetworkError.value = false;
                      if (kDebugMode) {
                        print("before: ${notNetworkError.value}");
                        print(widget.imageSrc);
                      }

                      setState(() {});
                    },
                    fit: widget.fill,
                  )),
            )
          : Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      fit: widget.fill,
                      image: AssetImage(widget.defaultImage))),
            ));
    }

    return SizedBox(
        height: widget.height, width: widget.width, child: imageWidget);
  }
}
