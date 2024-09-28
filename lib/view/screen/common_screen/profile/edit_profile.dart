import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../helpers/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/image/common_image.dart';
import '../../../component/text/common_text.dart';
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
            title: const CommonText(
              text: AppString.profile,
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
                      titleText: AppString.saveAndChanges,
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
