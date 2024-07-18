import 'package:flutter/material.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/sign_in_controller.dart';
import '../../../../../core/app_routes.dart';
import '../../../../../helpers/reg_exp_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import 'widget/do_not_account.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<SignInController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const CommonText(
                      text: AppString.logIntoYourAccount,
                      fontSize: 32,
                      bottom: 20,
                      top: 36,
                    ),
                    20.height,
                    CommonTextField(
                      controller: controller.emailController,
                      prefixIcon: const Icon(Icons.mail),
                      labelText: AppString.email,
                      validator: OtherHelper.emailValidator,
                    ),
                    40.height,
                    CommonTextField(
                      controller: controller.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      isPassword: true,
                      labelText: AppString.password,
                      validator: OtherHelper.passwordValidator,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: const CommonText(
                          text: AppString.forgotThePassword,
                          top: 10,
                          bottom: 30,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    CommonButton(
                      titleText: AppString.signIn,
                      isLoading: controller.isLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.signInUser();
                        }
                      },
                    ),
                    30.height,
                    const DoNotHaveAccount()
                  ],
                ),
              ),
            );
          },
        ));
  }
}
