import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/message/chat_controller.dart';
import '../../../../helpers/app_routes.dart';
import '../../../../helpers/my_extension.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/chat_list_model.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/other_widgets/common_loader.dart';
import '../../../component/screen/error_screen.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import 'widget/active_user.dart';
import 'widget/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const CommonText(
            text: AppString.inbox,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          )),
      body: GetBuilder<ChatController>(
        builder: (controller) => switch (controller.status) {
          Status.loading => const CommonLoader(),
          Status.error =>
            ErrorScreen(onTap: ChatController.instance.getChatRepo),
          Status.completed => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  CommonTextField(
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppString.searchDoctor,
                  ),
                  controller.activeUsers.isNotEmpty
                      ? const CommonText(
                          text: AppString.activeNow,
                          fontSize: 20,
                          top: 20,
                          fontWeight: FontWeight.w700,
                        ).start
                      : 0.height,
                  Container(
                    height: controller.activeUsers.isEmpty ? 0 : 70.h,
                    padding: EdgeInsets.only(top: 8.h),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.activeUsers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return activeUser(controller.activeUsers[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.chats.length,
                      padding: EdgeInsets.only(top: 16.h),
                      itemBuilder: (context, index) {
                        Chat item = controller.chats[index];
                        return GestureDetector(
                          onTap: () =>
                              Get.toNamed(AppRoutes.message, parameters: {
                            "chatId": item.id,
                            "name": item.participant.fullName,
                            "image": item.participant.image,
                          }),
                          child: chatListItem(
                            item: controller.chats[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}
