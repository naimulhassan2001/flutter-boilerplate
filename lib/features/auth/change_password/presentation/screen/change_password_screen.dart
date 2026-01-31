import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/change_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.changePassword,
          fontSize: 20,
          fontWeight: .w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  70.height,

                  /// current Password section
                  const CommonText(text: AppString.currentPassword, bottom: 8),
                  CommonTextField(
                    controller: controller.currentPasswordController,
                    hintText: AppString.currentPassword,
                    validator: AppValidation.password,
                    isPassword: true,
                  ),

                  /// New Password section
                  const CommonText(
                    text: AppString.newPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.newPasswordController,
                    hintText: AppString.newPassword,
                    validator: AppValidation.password,
                    isPassword: true,
                  ),

                  /// confirm Password section
                  const CommonText(
                    text: AppString.confirmPassword,
                    bottom: 8,
                    top: 16,
                  ),
                  CommonTextField(
                    controller: controller.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    validator: (value) => AppValidation.confirmPassword(
                      value,
                      controller.newPasswordController,
                    ),
                    isPassword: true,
                  ),

                  /// forget Password button
                  Align(
                    alignment: .centerLeft,
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: AppString.forgotPassword,
                        color: AppColors.primaryColor,
                        fontWeight: .w600,
                        fontSize: 18.sp,
                        top: 16.h,
                        bottom: 20.h,
                      ),
                    ),
                  ),

                  /// submit Button
                  CommonButton(
                    titleText: AppString.confirm,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.changePasswordRepo();
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
