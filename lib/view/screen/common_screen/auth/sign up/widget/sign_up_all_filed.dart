import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/app_string.dart';
import '../../../../../../extension/my_extension.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../../helpers/reg_exp_helper.dart';
import '../../../../../../utils/app_colors.dart';
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
          children: [
            CommonTextField(
              prefixIcon: const Icon(
                Icons.group,
              ),
              labelText: AppString.fullName,
              controller: controller.nameController,
              validator: OtherHelper.validator,
            ),
            30.height,
            CommonTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail, color: AppColors.black),
              labelText: AppString.email,
              validator: OtherHelper.emailValidator,
            ),
            30.height,
            CommonTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              labelText: AppString.password,
              validator: OtherHelper.passwordValidator,
            ),
            30.height,
            CommonTextField(
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.black),
              isPassword: true,
              labelText: AppString.confirmPassword,
              validator: (value) => OtherHelper.confirmPasswordValidator(
                  value, controller.passwordController),
            ),
            30.height,
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
