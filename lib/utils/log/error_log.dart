import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

void errorLog(
  dynamic e, {
  String source = "",
  String title = "",
}) {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  try {
    if (kDebugMode) {
      logger.e(""""
      >>>>>>>>>>>>>>>>>>>>>>>>>>>😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          
          $source

      >>>>>>>>>>>>>>>>>>>>>>>>>>>😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


     ➡️➡️➡️➡️➡️$title:========>  ${e.toString()} 🔚🔚🔚🔚🔚🔚🔚🔚
      

      <<<<<<<<<<<<<<<<<<<<<<<<<<<😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      """);
    }
  } catch (e) {
    ///////
  }
}
