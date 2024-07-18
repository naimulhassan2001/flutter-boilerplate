import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../helpers/prefs_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../common_widgets/button/common_button.dart';
import '../../../../common_widgets/text/common_text.dart';
import 'widget/already_accunt_rich_text.dart';
import 'widget/sign_up_all_filed.dart';
import '../../../../../extension/my_extension.dart';


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
                  CommonText(
                    text: "Create Your Account".tr,
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
                    titleText: "Sign up".tr,
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
