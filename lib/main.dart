import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/storage/storage_services.dart';
import 'package:flutter_boilerplate/utils/log/error_log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/dependency/dependency_injection.dart';
import 'config/route/app_routes.dart';
import 'config/theme/light_theme.dart';
import 'services/notification/notification_service.dart';
import 'services/socket/socket_service.dart';

init() async {
  try {
    await Future.wait(
        [LocalStorage.getAllPrefData(), dotenv.load(fileName: ".env")]);
  } catch (e) {
    errorLog(e, source: "app main ");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();

  await init();
  NotificationService.initLocalNotification();
  SocketServices.connectToSocket();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        defaultTransition: Transition.fadeIn,
        theme: themeData,
        transitionDuration: const Duration(milliseconds: 300),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
