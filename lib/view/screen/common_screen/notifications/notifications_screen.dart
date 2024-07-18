import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/notifications/notifications_controller.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/notification_model.dart';
import '../../../common_widgets/bottom_nav_bar/common_bottom_bar.dart';
import '../../../common_widgets/other_widgets/common_loader.dart';
import '../../../common_widgets/other_widgets/no_data.dart';
import '../../../common_widgets/screen/error_screen.dart';
import '../../../common_widgets/text/common_text.dart';
import 'widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Notification".tr,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
      ),
      body: GetBuilder<NotificationsController>(
        builder: (controller) {
          return switch (controller.status) {
            Status.loading => const CommonLoader(),
            Status.error => ErrorScreen(
                onTap: NotificationsController.instance.getNotificationsRepo),
            Status.completed => controller.notifications.isEmpty
                ? const NoData()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 10.sp),
                    itemCount: controller.notifications.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      NotificationModel item = controller.notifications[index];
                      return NotificationItem(
                        item: item,
                      );
                    },
                  )
          };
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}
