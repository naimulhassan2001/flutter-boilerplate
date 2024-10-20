import 'package:flutter/material.dart';
import '../../../../../helpers/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const CommonText(
            text: AppString.forgotPassword,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: AppString.email,
                  bottom: 8,
                  top: 80,
                ),
                CommonTextField(
                  controller: controller.emailController,
                  prefixIcon: const Icon(Icons.mail),
                  hintText: AppString.email,
                  validator: OtherHelper.emailValidator,
                ),
                100.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: CommonButton(
            titleText: AppString.continues,
            isLoading: controller.isLoadingEmail,
            onTap: () {
              if (formKey.currentState!.validate()) {
                controller.forgotPasswordRepo();
              }
            },
          ),
        ),
      ),
    );
  }
}
