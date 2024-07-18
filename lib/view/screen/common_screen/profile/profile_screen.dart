import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../common_widgets/bottom_nav_bar/common_bottom_bar.dart';
import '../../../common_widgets/image/common_image.dart';
import '../../../common_widgets/other_widgets/item.dart';
import '../../../common_widgets/pop_up/common_pop_menu.dart';
import '../../../common_widgets/text/common_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Profile".tr,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 85.sp,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: CommonImage(
                        imageSrc: AppImages.profile,
                        imageType: ImageType.png,
                        height: 170,
                        width: 170,
                        defaultImage: AppImages.profile,
                      ),
                    ),
                  ),
                ),
                const CommonText(
                  text: "Daniel Martinez",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  top: 20,
                  bottom: 24,
                ),
                Item(
                  icon: Icons.person,
                  title: "Edit Profile".tr,
                  onTap: () => Get.toNamed(AppRoutes.editProfile),
                ),

                Item(
                  icon: Icons.settings,
                  title: "Settings".tr,
                  onTap: () => Get.toNamed(AppRoutes.setting),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language),
                          CommonText(
                            text: controller.selectedLanguage,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            left: 16,
                          ),
                          const Spacer(),
                          PopUpMenu(
                              items: controller.languages,
                              selectedItem: [controller.selectedLanguage],
                              onTap: controller.selectLanguage)
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
                Item(
                  icon: Icons.logout,
                  title: "Log Out".tr,
                  onTap: () => logOutPopUp(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 3,
      ),
    );
  }
}
