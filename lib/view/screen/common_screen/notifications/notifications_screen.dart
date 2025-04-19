import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/notifications/notifications_controller.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../data/models/notification_model.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/other_widgets/common_loader.dart';
import '../../../component/other_widgets/no_data.dart';
import '../../../component/text/common_text.dart';
import 'widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: ApiEndPoint.notifications,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
      ),
      body: GetBuilder<NotificationsController>(
        builder: (controller) {
          return controller.isLoading
              ? const CommonLoader()
              : controller.notifications.isEmpty
              ? const NoData()
              : ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 10.sp,
                ),
                itemCount:
                    controller.isLoadingMore
                        ? controller.notifications.length + 1
                        : controller.notifications.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index > controller.notifications.length) {
                    return CommonLoader(size: 40, strokeWidth: 2);
                  }
                  NotificationModel item = controller.notifications[index];
                  return NotificationItem(item: item);
                },
              );
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 1),
    );
  }
}
