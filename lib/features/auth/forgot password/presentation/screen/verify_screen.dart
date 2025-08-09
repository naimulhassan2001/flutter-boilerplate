import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_untitled/utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/helpers/other_helper.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../../utils/constants/app_string.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  /// init State here
  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder:
          (controller) => Scaffold(
            /// App Bar Section
            appBar: AppBar(),

            /// body section
            body: Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      20.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CommonImage(imageSrc: AppImages.verifyOtp),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 34,
                      bottom: 72,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff9D9D9D).withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// forget password take email for reset Password
                          const CommonText(
                            text: AppString.verifyYourOTP,
                            bottom: 4,
                            fontSize: 18,
                            color: AppColors.black_400,
                          ),
                          const CommonText(
                            text: AppString.verifyYourOTPDetails,
                            bottom: 16,
                            color: AppColors.black_300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            maxLines: 3,
                          ),

                          Flexible(
                            flex: 0,
                            child: PinCodeTextField(
                              controller: controller.otpController,
                              autoDisposeControllers: false,
                              cursorColor: AppColors.black,
                              appContext: (context),
                              autoFocus: true,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldHeight: 48.sp,
                                fieldWidth: 48.sp,
                                activeFillColor: AppColors.transparent,
                                selectedFillColor: AppColors.transparent,
                                inactiveFillColor: AppColors.transparent,
                                selectedColor: AppColors.primaryColor,
                                activeColor: AppColors.primaryColor,
                                inactiveColor: AppColors.black,
                              ),
                              length: 6,
                              keyboardType: TextInputType.number,
                              autovalidateMode: AutovalidateMode.disabled,
                              enableActiveFill: true,
                              validator: (value) {
                                if (value != null && value.length == 6) {
                                  return null;
                                } else {
                                  return AppString.otpIsInValid;
                                }
                              },
                            ),
                          ),

                          CommonText(
                            text:
                                "${AppString.resendCodeIn} ${controller.time}",
                            color: AppColors.black_300,
                            bottom: 20,
                            top: 16,
                          ),

                          CommonButton(
                            titleText: AppString.sendResetCode,
                            isLoading: controller.isLoadingEmail,
                            titleColor: AppColors.white_500,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                controller.verifyOtpRepo();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
