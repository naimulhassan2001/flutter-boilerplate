import 'package:flutter/material.dart';
import '../../../../../helpers/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../helpers/prefs_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import 'widget/already_accunt_rich_text.dart';
import 'widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<SignUpController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(children: [
                  const CommonText(
                    text: AppString.createYourAccount,
                    fontSize: 32,
                    bottom: 20,
                  ),
                  const SignUpAllField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                              value: controller.selectedOption[0],
                              groupValue: controller.selectRole,
                              activeColor: AppColors.primaryColor,
                              onChanged: controller.setSelectedRole),
                          CommonText(
                            text: controller.selectedOption[0],
                            fontSize: 18,
                            color: controller.selectRole ==
                                    controller.selectedOption[0]
                                ? AppColors.primaryColor
                                : AppColors.black,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: controller.selectedOption[1],
                              groupValue: controller.selectRole,
                              activeColor: AppColors.primaryColor,
                              onChanged: controller.setSelectedRole),
                          CommonText(
                            text: controller.selectedOption[1],
                            fontSize: 18,
                            color: controller.selectRole ==
                                    controller.selectedOption[1]
                                ? AppColors.primaryColor
                                : AppColors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                  16.height,
                  CommonButton(
                    titleText: AppString.signUp,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.signUpUser();
                        PrefsHelper.myRole = controller.selectRole;
                      }
                    },
                  ),
                  24.height,
                  const AlreadyAccountRichText()
                ]),
              ),
            );
          },
        ));
  }
}
