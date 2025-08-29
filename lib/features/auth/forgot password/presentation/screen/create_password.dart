import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_images.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/helpers/other_helper.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) {
        return Scaffold(
          /// App Bar Section
          appBar: AppBar(),

          /// body section
          body: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    30.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CommonImage(imageSrc: AppImages.createPassword),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 34,
                    bottom: 72,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff9D9D9D).withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// forget password take email for reset Password
                        const CommonText(
                          text: AppString.verifyYourOTP,
                          bottom: 4,
                          fontSize: 18,
                          color: AppColors.black_400,
                        ).center,
                        const CommonText(
                          text: AppString.verifyYourOTPDetails,
                          bottom: 16,
                          color: AppColors.black_300,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          maxLines: 3,
                        ),

                        CommonText(
                          text: AppString.createNewPassword,
                          color: AppColors.black_300,
                          bottom: 6,
                        ),
                        CommonTextField(
                          controller: controller.passwordController,
                        ),

                        CommonText(
                          text: AppString.confirmPassword,
                          top: 12,
                          bottom: 6,
                          color: AppColors.black_300,
                        ),
                        CommonTextField(
                          controller: controller.confirmPasswordController,
                        ),

                        20.height,
                        CommonButton(
                          titleText: AppString.confirm,
                          isLoading: controller.isLoadingEmail,
                          titleColor: AppColors.white_500,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.resetPasswordRepo();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
