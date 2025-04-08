import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'services/notification/notification_service.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';
import 'utils/log/error_log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

init() async {
  try {
    DependencyInjection dI = DependencyInjection();
    dI.dependencies();
    NotificationService.initLocalNotification();
    SocketServices.connectToSocket();

    await Future.wait([
      LocalStorage.getAllPrefData(),
      dotenv.load(fileName: ".env"),
    ]);
  } catch (e) {
    errorLog(
      "Error loading preferences or environment variables: $e",
      source: "Main file",
    );
  }
}
