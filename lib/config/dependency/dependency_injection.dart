import 'package:get/get.dart';

import '../../features/auth/change_password/presentation/controller/change_password_controller.dart';
import '../../features/auth/forgot password/presentation/controller/forget_password_controller.dart';
import '../../features/auth/sign_in/data/datasources/sign_in_remote_data_source.dart';
import '../../features/auth/sign_in/data/repositories/sign_in_repository_impl.dart';
import '../../features/auth/sign_in/domain/repositories/sign_in_repository.dart';
import '../../features/auth/sign_in/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/sign_in/presentation/controller/sign_in_controller.dart';
import '../../features/auth/sign up/presentation/controller/sign_up_controller.dart';
import '../../services/api/api_client.dart';
import '../../services/api/api_service.dart';
import '../../features/message/presentation/controller/chat_controller.dart';
import '../../features/message/presentation/controller/message_controller.dart';
import '../../features/notifications/presentation/controller/notifications_controller.dart';
import '../../features/profile/presentation/controller/profile_controller.dart';
import '../../features/setting/presentation/controller/privacy_policy_controller.dart';
import '../../features/setting/presentation/controller/setting_controller.dart';
import '../../features/setting/presentation/controller/terms_of_services_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => DioApiClient(), fenix: true);

    Get.lazyPut<SignInRemoteDataSource>(
      () => SignInRemoteDataSourceImpl(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<SignInRepository>(
      () => SignInRepositoryImpl(Get.find<SignInRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut(
      () => SignInUseCase(Get.find<SignInRepository>()),
      fenix: true,
    );

    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(Get.find<SignInUseCase>()), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServicesController(), fenix: true);
  }
}
