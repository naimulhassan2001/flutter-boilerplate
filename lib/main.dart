import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/utils/log/error_log.dart';
import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        globalError(details.exception, details.stack);
      };

      runApp(const MyApp());

      // Run heavy work AFTER UI loads
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await init();
      });
    },
    (error, stack) {
      globalError(error, stack);
    },
  );
}

Future<void> init() async {
  try {
    final dI = DependencyInjection();
    dI.dependencies();
    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      LocalStorage.getAllPrefData(),
    ]);

    Future.delayed(const Duration(milliseconds: 300), () {
      SocketServices.connectToSocket();
    });
  } catch (e, stack) {
    globalError(e, stack);
  }
}
