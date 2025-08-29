import 'package:flutter/material.dart';
import 'package:new_untitled/component/image/common_image.dart';
import 'package:new_untitled/utils/constants/app_icons.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/helpers/other_helper.dart';
import '../widgets/do_not_account.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Sections Starts here
      appBar: AppBar(),

      /// Body Sections Starts here
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    validator: OtherHelper.emailValidator,
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
                    validator: OtherHelper.passwordValidator,
                  ),

                  /// Forget Password Button here
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: const CommonText(
                        text: AppString.forgotThePassword,
                        top: 10,
                        bottom: 30,
                        color: Color(0xffED3528),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  /// Submit Button here
                  CommonButton(
                    titleText: AppString.logIn,
                    isLoading: controller.isLoading,
                    onTap: controller.signInUser,
                  ),
                  30.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImage(imageSrc: AppIcons.google),
                      20.width,
                      CommonImage(imageSrc: AppIcons.apple),
                    ],
                  ),

                  30.height,

                  /// Account Creating Instruction here
                  const DoNotHaveAccount().center,
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
