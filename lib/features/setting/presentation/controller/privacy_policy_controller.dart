import 'package:get/get.dart';

import '../../data/model/html_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/enum/enum.dart';

class PrivacyPolicyController extends GetxController {
  /// API status
  Status status = Status.completed;

  /// HTML data
  HtmlModel data = const HtmlModel(id: '', content: '');

  /// Instance (for lazyPut/bindings)
  static PrivacyPolicyController get instance => Get.find();

  /// Fetch privacy policy
  Future<void> getPrivacyPolicy() async {
    try {
      status = Status.loading;
      update();

      final response =
      await ApiService.get(ApiEndPoint.privacyPolicies);

      if (response.statusCode != 200) {
        throw Exception(response.message);
      }

      final Map<String, dynamic> raw =
          response.data?['data']?['attributes'] ?? {};

      data = HtmlModel.fromJson(raw);

      status = Status.completed;
    } catch (e) {
      status = Status.error;

      AppSnackbar.error(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicy();
  }
}
