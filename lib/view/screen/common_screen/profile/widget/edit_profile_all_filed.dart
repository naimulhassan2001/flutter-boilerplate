import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../helpers/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/pop_up/common_pop_menu.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_phone_number_text_filed.dart';
import '../../../../component/text_field/common_text_field.dart';

class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: AppString.fullName,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              bottom: 12,
            ),
            CommonTextField(
              controller: controller.nameController,
              validator: OtherHelper.validator,
              hintText: AppString.fullName,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.text,
              borderColor: AppColors.black,
              fillColor: AppColors.transparent,
            ),
            const CommonText(
              text: AppString.contact,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              top: 20,
              bottom: 12,
            ),
            CommonPhoneNumberTextFiled(
              controller: controller.numberController,
              countryChange: (value) {
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            20.height,
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: AppString.dateOfBirth,
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
                      hintText: AppString.dateOfBirth,
                    ),
                  ],
                )),
                20.height,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: AppString.age,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      bottom: 12,
                    ),
                    CommonTextField(
                      controller: controller.ageController,
                      validator: OtherHelper.validator,
                      keyboardType: TextInputType.number,
                      hintText: AppString.age,
                      borderColor: AppColors.black,
                      fillColor: AppColors.transparent,
                    ),
                  ],
                )),
              ],
            ),
            const CommonText(
              text: AppString.aboutMe,
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
              hintText: AppString.aboutMe,
            ),
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: AppString.gender,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                SizedBox(
                  width: 150.w,
                  child: CommonTextField(
                    controller: controller.genderController,
                    fillColor: AppColors.black,
                    hintText: AppString.gender,
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
