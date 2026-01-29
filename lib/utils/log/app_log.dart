import 'package:flutter/foundation.dart';
import 'error_log.dart';

void appLog(dynamic message, {String source = ''}) {
  try {
    if (kDebugMode) {
      debugPrint("""
${source.isNotEmpty ? ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" : ""}
      $source
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

               =============>${message.toString()}

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

""");
    }
  } catch (e) {
    errorLog(e, source: 'App Log');
  }
}


void setupGlobalLogging() {
  final originalDebugPrint = debugPrint;

  debugPrint = (String? message, {int? wrapWidth}) {
    if (message == null) return;

    originalDebugPrint('➡️debugPrint: $message', wrapWidth: wrapWidth);
  };
}
