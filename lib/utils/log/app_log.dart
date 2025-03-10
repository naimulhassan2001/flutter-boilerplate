import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'error_log.dart';

void appLog(dynamic message, {String source = '', String title = ''}) {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  try {
    if (kDebugMode) {
      logger.d("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ==========>$source
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  ==========>$title: ========>${message.toString()}

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

""");
    }
  } catch (e) {
    errorLog(e, source: "App Log");
  }
}
