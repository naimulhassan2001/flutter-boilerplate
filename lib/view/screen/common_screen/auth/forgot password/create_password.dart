import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../services/validation/validation_service.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.createNewPassword,
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
                  const Center(
                    child: CommonImage(
                      imageSrc: AppImages.noImage,
                      height: 297,
                      width: 297,
                    ),
                  ),
                  const CommonText(
                    text: AppString.createYourNewPassword,
                    fontSize: 18,
                    textAlign: TextAlign.start,
                    top: 64,
                    bottom: 24,
                  ),
                  const CommonText(
                    text: AppString.password,
                    bottom: 8,
                  ),
                  CommonTextField(
                    controller: controller.passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppString.password,
                    isPassword: true,
                    validator: ValidationService.passwordValidator,
                  ),
                  const CommonText(
                    text: AppString.password,
                    bottom: 8,
                    top: 12,
                  ),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppString.confirmPassword,
                    validator: (value) => ValidationService.confirmPasswordValidator(
                        value, controller.passwordController),
                    isPassword: true,
                  ),
                  64.height,
                  CommonButton(
                    titleText: AppString.continues,
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
