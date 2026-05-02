import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/sign_in_controller.dart';
import '../widgets/do_not_have_account.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const CommonText(
                    text: AppString.logIntoYourAccount,
                    fontSize: 32,
                    bottom: 20,
                    top: 36,
                  ),
                  const CommonText(text: AppString.email, bottom: 8),
                  CommonTextField(
                    controller: controller.emailController,
                    hintText: AppString.email,
                    validator: AppValidation.email,
                  ),
                  const CommonText(
                    text: AppString.password,
                    bottom: 8,
                    top: 24,
                  ),
                  CommonTextField(
                    controller: controller.passwordController,
                    isPassword: true,
                    hintText: AppString.password,
                    validator: AppValidation.password,
                  ),
                  Align(
                    alignment: .centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: const CommonText(
                        text: AppString.forgotThePassword,
                        top: 10,
                        bottom: 30,
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: .w600,
                      ),
                    ),
                  ),
                  CommonButton(
                    titleText: AppString.signIn,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      controller.submit();
                    },
                  ),
                  30.height,
                  const DoNotHaveAccount(),
                  30.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
