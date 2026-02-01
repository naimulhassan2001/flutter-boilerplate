import 'package:flutter/material.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/sign_in_controller.dart';

import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../widgets/do_not_account.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Sections Starts here
      appBar: AppBar(),

      /// Body Sections Starts here
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  /// Log In Instruction here
                  const CommonText(
                    text: AppString.logIntoYourAccount,
                    fontSize: 32,
                    bottom: 20,
                    top: 36,
                  ),

                  /// Account Email Input here
                  const CommonText(text: AppString.email, bottom: 8),
                  CommonTextField(
                    controller: controller.emailController,
                    hintText: AppString.email,
                    validator: AppValidation.email,
                  ),

                  /// Account Password Input here
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

                  /// Forget Password Button here
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

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.signIn,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      controller.signInUser();
                    },
                  ),
                  30.height,

                  /// Account Creating Instruction here
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
