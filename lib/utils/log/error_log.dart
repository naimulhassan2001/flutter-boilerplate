import 'dart:developer';

import 'package:flutter/foundation.dart';

void errorLog(dynamic e, {String source = ''}) {
  try {
    if (kDebugMode) {
      log('''
      >>>>>>>>>>>>>>>>>>>>>>>>>>>😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          
          $source

      >>>>>>>>>>>>>>>>>>>>>>>>>>>😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


     ➡️➡️➡️➡️➡️ :========>  ${e.toString()} 🔚🔚🔚🔚🔚🔚🔚🔚
      

      <<<<<<<<<<<<<<<<<<<<<<<<<<<😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      ''');
    }
  } catch (e) {
    ///////
  }
}


void globalError(Object error, StackTrace? stack) {
  debugPrint(' Global Error ❌ ERROR: $error');

  if (stack != null) {
    debugPrint('Global Error 📌 STACK TRACE:\n$stack');
  }



  // Optional: Send to remote logging
  // FirebaseCrashlytics.instance.recordError(error, stack);
}
