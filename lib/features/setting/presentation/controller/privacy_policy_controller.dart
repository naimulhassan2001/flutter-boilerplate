import 'package:get/get.dart';
import '../../data/model/html_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/enum/enum.dart';

class PrivacyPolicyController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  ///  HTML model initialize here
  HtmlModel data = HtmlModel.fromJson({});

  /// Privacy Policy Controller instance create here
  static PrivacyPolicyController get instance =>
      Get.put(PrivacyPolicyController());

  /// Privacy Policy Api call here
  Future<void> getPrivacyPolicyRepo() async {
    return;
    status = Status.loading;
    update();

    final response = await ApiService.get(ApiEndPoint.privacyPolicies);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};
      final Map<String, dynamic> attributes = data['attributes'] ?? {};
      this.data = HtmlModel.fromJson(attributes);

      status = Status.completed;
      update();
    } else {
      AppSnackbar.error(
        title: response.statusCode.toString(),
        message: response.message,
      );
      status = Status.error;
      update();
    }
  }

  /// Controller on Init here
  @override
  void onInit() {
    getPrivacyPolicyRepo();
    super.onInit();
  }
}
