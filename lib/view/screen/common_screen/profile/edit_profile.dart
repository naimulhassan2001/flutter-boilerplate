import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/extension/my_extension.dart';
import 'package:flutter_boilerplate/view/common_widgets/button/common_button.dart';
import 'package:flutter_boilerplate/view/common_widgets/image/common_image.dart';
import 'package:flutter_boilerplate/view/common_widgets/text/common_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import 'widget/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CommonText(
              text: "Book Appointment".tr,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 85.sp,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: controller.image != null
                                ? Image.file(
                                    File(controller.image!),
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.fill,
                                  )
                                : CommonImage(
                                    imageSrc: AppImages.profile,
                                    imageType: ImageType.png,
                                    height: 170,
                                    width: 170,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: Get.width * 0.53,
                          child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateColor.resolveWith(
                                (states) => Colors.black,
                              )),
                              onPressed: controller.getProfileImage,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  const EditProfileAllFiled(),
                  30.height,
                  CommonButton(
                      titleText: "Save Changes".tr,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Get.toNamed(AppRoutes.patientsProfile);
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
