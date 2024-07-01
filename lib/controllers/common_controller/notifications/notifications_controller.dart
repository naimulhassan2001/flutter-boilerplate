import 'dart:convert';

import 'package:get/get.dart';

import '../../../models/api_response_model.dart';
import '../../../models/notification_model.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';

class NotificationsController extends GetxController {
  List notifications = [];
  Status status = Status.completed;

  getNotificationsRepo() async {
    return;
    status = Status.loading;
    update();

    var response = await ApiService.getApi(AppUrls.notifications);

    if (response.statusCode == 200) {
      var notificationList =
          jsonDecode(response.body)['data']['attributes']['notificationList'];

      for (var notification in notificationList) {
        notifications.add(NotificationModel.fromJson(notification));
      }

      status = Status.completed;
      update();
    } else {
      status = Status.error;
      update();
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  static NotificationsController get instance =>
      Get.put(NotificationsController());

  @override
  void onInit() {
    getNotificationsRepo();
    super.onInit();
  }
}
