
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../helpers/reg_exp_helper.dart';
import '../../../../../utils/app_images.dart';
import '../../../../common_widgets/button/common_button.dart';
import '../../../../common_widgets/image/common_image.dart';
import '../../../../common_widgets/text/common_text.dart';
import '../../../../common_widgets/text_field/common_text_field.dart';
import '../../../../../extension/my_extension.dart';



class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: "Create New Password".tr,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  64.height,
                  Center(
                    child: CommonImage(
                      imageSrc: AppImages.noImage,
                      imageType: ImageType.png,
                      height: 297,
                      width: 297,
                    ),
                  ),
                  CommonText(
                    text: "Create Your New Password".tr,
                    fontSize: 18,
                    textAlign: TextAlign.start,
                    top: 64,
                    bottom: 24,
                  ),
                  CommonTextField(
                    controller: controller.passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Password".tr,
                    isPassword: true,
                    validator: OtherHelper.passwordValidator,
                  ),
                  24.height,
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock),
                    labelText: "Confirm Password".tr,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                        value, controller.passwordController),
                    isPassword: true,
                  ),
                  64.height,
                  CommonButton(
                    titleText: "Continue".tr,
                    isLoading: controller.isLoadingReset,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                       controller.resetPasswordRepo();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
