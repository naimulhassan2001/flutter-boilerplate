import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/utils/log/error_log.dart';
import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

Future<void> init() async {
  try {
    DependencyInjection dI = DependencyInjection();
    dI.dependencies();
    SocketServices.connectToSocket();

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      LocalStorage.getAllPrefData(),

      /// TODO : Need to UnComment
      // NotificationService.initLocalNotification(),
      dotenv.load(fileName: ".env"),
    ]);
  } catch (e) {
    errorLog(e, source: "main.dart");
  }
}
