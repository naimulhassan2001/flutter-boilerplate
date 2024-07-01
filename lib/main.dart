
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/app_routes.dart';
import 'core/dependency_injection.dart';
import 'helpers/prefs_helper.dart';
<<<<<<< HEAD
import 'languages/language.dart';
=======
>>>>>>> 2549ed6079da91cbacb2737d53b6e546746db39e
import 'services/notification_service.dart';
import 'services/socket_service.dart';
import 'theme/light_theme.dart';

<<<<<<< HEAD
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

=======



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


>>>>>>> 2549ed6079da91cbacb2737d53b6e546746db39e
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  await PrefsHelper.getAllPrefData();
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
<<<<<<< HEAD
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
        initialRoute: AppRoutes.splash,
=======
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: AppRoutes.test,
>>>>>>> 2549ed6079da91cbacb2737d53b6e546746db39e
        getPages: AppRoutes.routes,
      ),
    );
  }
}
