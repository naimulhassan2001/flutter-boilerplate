import 'package:get/get.dart';

import '../../../models/api_response_model.dart';
import '../../../models/html_model.dart';
import '../../../services/api_service.dart';
import '../../../core/api_end_point/app_url.dart';
import '../../../utils/app_utils.dart';

class TermsOfServicesController extends GetxController {
  Status status = Status.completed;

  HtmlModel data = HtmlModel.fromJson({});

  static TermsOfServicesController get instance =>
      Get.put(TermsOfServicesController());

  geTermsOfServicesRepo() async {
    return;
    status = Status.loading;
    update();

    var response = await ApiService.getApi(ApiEndPoint.termsOfServices);

    if (response.statusCode == 200) {
      data =
          HtmlModel.fromJson(response.body['data']['attributes']);

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  @override
  void onInit() {
    geTermsOfServicesRepo();
    super.onInit();
  }
}
