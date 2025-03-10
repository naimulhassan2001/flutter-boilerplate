
import 'package:get/get.dart';
import '../../../data/models/notification_model.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/constants/api_end_point.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/enum/enum.dart';

class NotificationsController extends GetxController {
  List notifications = [];
  Status status = Status.completed;

  getNotificationsRepo() async {
    return;
    status = Status.loading;
    update();

    var response = await ApiService.get(ApiEndPoint.notifications);

    if (response.statusCode == 200) {
      var notificationList =
          response.body['data']['attributes']['notificationList'];

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
