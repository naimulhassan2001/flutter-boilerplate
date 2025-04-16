import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:new_untitled/utils/extensions/extension.dart';

import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'services/notification/notification_service.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.tryCatch();

  runApp(const MyApp());
}

init() async {
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  NotificationService.initLocalNotification();
  SocketServices.connectToSocket();

  dynamic num = 0;
  num = num + "4f";

  await Future.wait([
    LocalStorage.getAllPrefData(),
    dotenv.load(fileName: ".env"),
  ]);
}
