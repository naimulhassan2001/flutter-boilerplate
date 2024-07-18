import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../../helpers/reg_exp_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../common_widgets/pop_up/common_pop_menu.dart';
import '../../../../../extension/my_extension.dart';
import '../../../../common_widgets/text/common_text.dart';
import '../../../../common_widgets/text_field/common_text_field.dart';


class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: "Full Name".tr,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              bottom: 12,
            ),
            CommonTextField(
              controller: controller.nameController,
              validator: OtherHelper.validator,
              hintText: "Full Name".tr,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.text,
              borderColor: AppColors.black,
              fillColor: AppColors.transparent,
            ),
            CommonText(
              text: "Contact".tr,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              top: 20,
              bottom: 12,
            ),
            IntlPhoneField(
              controller: controller.numberController,
              onChanged: (value) {
                if (kDebugMode) {
                  print(value);
                }
              },
              decoration: InputDecoration(
                hintText: "Phone Number".tr,
                fillColor: AppColors.transparent,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 14.h),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              initialCountryCode: "BD",
              disableLengthCheck: false,
            ),
            20.height,
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Date of birth".tr,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      bottom: 12,
                    ),
                    CommonTextField(
                      controller: controller.dateOfBirthController,
                      validator: OtherHelper.validator,
                      keyboardType: TextInputType.none,
                      borderColor: AppColors.black,
                      fillColor: AppColors.transparent,
                      borderRadius: 10.r,
                      onTap: () => OtherHelper.datePicker(
                          controller.dateOfBirthController),
                      hintText: "Date of birth".tr,
                    ),
                  ],
                )),
                20.height,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Age".tr,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      bottom: 12,
                    ),
                    CommonTextField(
                      controller: controller.ageController,
                      validator: OtherHelper.validator,
                      keyboardType: TextInputType.number,

                      hintText: "Age".tr,
                      borderColor: AppColors.black,
                      fillColor: AppColors.transparent,
                    ),
                  ],
                )),
              ],
            ),
            CommonText(
              text: "About Me".tr,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              bottom: 12,
            ),
            CommonTextField(
              controller: controller.descriptionController,
              validator: OtherHelper.validator,
              keyboardType: TextInputType.number,
              borderColor: AppColors.black,
              fillColor: AppColors.transparent,
              hintText: "About Me".tr,
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: "Gender".tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(
                  width: 150.w,
                  child: CommonTextField(
                    controller: controller.genderController,
                    fillColor: AppColors.black,
                    hintText: 'Gender'.tr,
                    suffixIcon: PopUpMenu(
                        items: controller.gender,
                        iconColor: AppColors.white,
                        selectedItem: [controller.genderController.text],
                        onTap: controller.selectedGender),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
