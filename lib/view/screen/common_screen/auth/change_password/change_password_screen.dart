import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/view/component/text_field/common_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/validation/validation_service.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../controllers/common_controller/auth/change_password_controller.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.changePassword,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  70.height,
                  const CommonText(
                    text: AppString.currentPassword,
                    bottom: 8,
                  ),
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    hintText: AppString.currentPassword,
                    validator: ValidationService.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  const CommonText(
                    text: AppString.newPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.newPasswordController,
                    hintText: AppString.newPassword,
                    validator: ValidationService.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  const CommonText(
                    text: AppString.confirmPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    validator: (value) => ValidationService.confirmPasswordValidator(
                        value, controller.newPasswordController),
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: AppString.forgotPassword,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        top: 16.h,
                        bottom: 20.h,
                      ),
                    ),
                  ),
                  CommonButton(
                    titleText: AppString.confirm,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.changePasswordRepo();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
