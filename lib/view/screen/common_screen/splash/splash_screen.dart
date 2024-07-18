import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../common_widgets/image/common_image.dart';
import '../../../common_widgets/other_widgets/common_loader.dart';
import '../../../../../extension/my_extension.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // if (PrefsHelper.isLogIn) {
        //   if (PrefsHelper.myRole == 'consultant') {
        //     Get.offAllNamed(AppRoutes.doctorHome);
        //   } else {
        //     Get.offAllNamed(AppRoutes.patientsHome);
        //   }
        // } else {
          Get.offAllNamed(AppRoutes.onboarding);

      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child: CommonImage(
              imageSrc: AppImages.noImage,
              height: 70,
              imageType: ImageType.png,
            )),
            const Spacer(),
            const CommonLoader(),
           20.height,
          ],
        ),
      ),
    );
  }
}
