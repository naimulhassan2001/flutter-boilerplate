import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationsController extends GetxController {
  List notifications = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasNoData = false;

  int page = 0;

  ScrollController scrollController = ScrollController();

  void moreNotification() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLoadingMore || hasNoData) return;
        isLoadingMore = true;
        update();
        page++;
        List<NotificationModel> list = await notificationRepository(page);
        if (list.isEmpty) {
          hasNoData = true;
        } else {
          notifications.addAll(list);
        }
        isLoadingMore = false;
        update();
      }
    });
  }

  getNotificationsRepo() async {
    if (isLoading || hasNoData) return;
    isLoading = true;
    update();

    page++;
    List<NotificationModel> list = await notificationRepository(page);
    if (list.isEmpty) {
      hasNoData = true;
    } else {
      notifications.addAll(list);
    }
    isLoading = false;
    update();
  }

  static NotificationsController get instance =>
      Get.put(NotificationsController());

  @override
  void onInit() {
    getNotificationsRepo();
    moreNotification();
    super.onInit();
  }
}
