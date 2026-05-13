import 'package:get/get.dart';

import '../presentation/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
  }
}
