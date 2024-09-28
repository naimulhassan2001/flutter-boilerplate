import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../../helpers/other_helper.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_phone_number_text_filed.dart';
import '../../../../../component/text_field/common_text_field.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: AppString.fullName,
              top: 30.h,
              bottom: 8.h,
            ),
            CommonTextField(
              prefixIcon: const Icon(
                Icons.person,
              ),
              hintText: AppString.fullName,
              controller: controller.nameController,
              validator: OtherHelper.validator,
            ),
            CommonText(
              text: AppString.email,
              top: 16.h,
              bottom: 8.h,
            ),
            CommonTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail, color: AppColors.black),
              hintText: AppString.email,
              validator: OtherHelper.emailValidator,
            ),
            CommonText(
              text: AppString.password,
              top: 16.h,
              bottom: 8.h,
            ),
            CommonTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              hintText: AppString.password,
              validator: OtherHelper.passwordValidator,
            ),
            CommonText(
              text: AppString.confirmPassword,
              top: 16.h,
              bottom: 8.h,
            ),
            CommonTextField(
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              labelText: AppString.confirmPassword,
              validator: (value) => OtherHelper.confirmPasswordValidator(
                  value, controller.passwordController),
            ),
            CommonText(
              text: AppString.phoneNumber,
              top: 16.h,
              bottom: 8.h,
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
