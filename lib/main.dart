import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/languages/language.dart';
import 'core/theme/light_theme.dart';
import 'core/route/app_routes.dart';
import 'core/dependency/dependency_injection.dart';
import 'helpers/prefs_helper.dart';
import 'services/notification_service.dart';
import 'services/socket_service.dart';

init() async {
  try {
    await Future.wait(
        [PrefsHelper.getAllPrefData(), dotenv.load(fileName: "lib/core/.env")]);
  } catch (e) {
    print("Error loading preferences or environment variables: $e");
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
        translations: LocalConstants(),
        defaultTransition: Transition.noTransition,
        locale: Locale(PrefsHelper.localizationLanguageCode,
            PrefsHelper.localizationCountryCode),
        fallbackLocale: const Locale("en", "US"),
        theme: themeData,
        transitionDuration: const Duration(milliseconds: 300),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
