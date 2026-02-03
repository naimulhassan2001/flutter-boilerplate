import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/model/notification_model.dart';

Future<List<NotificationModel>> notificationRepository(int page) async {
  try {
    final response = await ApiService.get(
      '${ApiEndPoint.notifications}?page=$page',
    );

    if (response.statusCode != 200) {
      throw Exception(response.message);
    }

    final List<dynamic> rawList = response.data['data'] ?? [];

    return rawList.map((e) => NotificationModel.fromJson(e)).toList();
  } catch (e) {
    rethrow;
  }
}
