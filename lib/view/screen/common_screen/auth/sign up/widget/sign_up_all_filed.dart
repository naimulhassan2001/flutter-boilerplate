import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../services/validation/validation_service.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../../utils/constants/app_string.dart';

import '../../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../component/text_field/common_phone_number_text_filed.dart';

class SignUpAllField extends StatefulWidget {
  const SignUpAllField({super.key});

  @override
  State<SignUpAllField> createState() => _SignUpAllFieldState();
}

class _SignUpAllFieldState extends State<SignUpAllField> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: AppString.fullName,
              bottom: 8,
              top: 12,
            ),
            CommonTextField(
              prefixIcon: const Icon(
                Icons.group,
              ),
              hintText: AppString.fullName,
              controller: controller.nameController,
              validator: ValidationService.validator,
            ),
            const CommonText(
              text: AppString.email,
              bottom: 8,
              top: 12,
            ),
            CommonTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail, color: AppColors.black),
              hintText: AppString.email,
              validator: ValidationService.emailValidator,
            ),
            const CommonText(
              text: AppString.password,
              bottom: 8,
              top: 12,
            ),
            CommonTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              hintText: AppString.password,
              validator: ValidationService.passwordValidator,
            ),
            const CommonText(
              text: AppString.confirmPassword,
              bottom: 8,
              top: 12,
            ),
            CommonTextField(
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              hintText: AppString.confirmPassword,
              validator: (value) => ValidationService.confirmPasswordValidator(
                  value, controller.passwordController),
            ),
            const CommonText(
              text: AppString.phoneNumber,
              bottom: 8,
              top: 12,
            ),
            CommonPhoneNumberTextFiled(
              controller: controller.numberController,
              countryChange: controller.onCountryChange,
            ),
          ],
        );
      },
    );
  }
}
