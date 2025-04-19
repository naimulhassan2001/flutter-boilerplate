import 'package:get/get.dart';
import '../../../data/models/html_model.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/enum/enum.dart';

class TermsOfServicesController extends GetxController {
  Status status = Status.completed;

  HtmlModel data = HtmlModel.fromJson({});

  static TermsOfServicesController get instance =>
      Get.put(TermsOfServicesController());

  geTermsOfServicesRepo() async {
    return;
    status = Status.loading;
    update();

    var response = await ApiService.get(ApiEndPoint.termsOfServices);

    if (response.statusCode == 200) {
      data = HtmlModel.fromJson(response.data['data']['attributes']);

      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
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
