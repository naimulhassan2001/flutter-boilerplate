import 'package:flutter/foundation.dart';

void globalError(Object error, StackTrace? stack) {
  debugPrint(' Global Error ❌ ERROR: $error');
  if (stack != null) {
    debugPrint('Global Error 📌 STACK TRACE:\n$stack');
  }
  // Optional: Send to remote logging
  // FirebaseCrashlytics.instance.recordError(error, stack);
}

void setupGlobalLogging() {
  final originalDebugPrint = debugPrint;
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message == null) return;
    originalDebugPrint('➡️debugPrint: $message', wrapWidth: wrapWidth);
  };
}
