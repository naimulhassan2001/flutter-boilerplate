import 'package:flutter_boilerplate/data/models/notification_model.dart';

import '../../services/api/api_service.dart';
import '../../utils/constants/api_end_point.dart';

Future<List<NotificationModel>> notificationRepository(int page) async {
  var response =
      await ApiService.get("${ApiEndPoint.notifications}?page=$page");

  if (response.statusCode == 200) {
    var notificationList = response.data['data'] ?? [];

    List<NotificationModel> list = [];

    for (var notification in notificationList) {
      list.add(NotificationModel.fromJson(notification));
    }

    return list;
  } else {
    return [];
  }
}
