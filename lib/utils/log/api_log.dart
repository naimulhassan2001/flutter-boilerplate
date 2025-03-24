import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/utils/log/error_log.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';


void apiRequestLog(RequestOptions options) {
  var logger = Logger(printer: YellowPrinter());

  try {
    if (kDebugMode) {
      logger.i("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ==========> ℹ️📡🔗🛠️🌐🔍 API Request Info ℹ️📡🔗🛠️🌐🔍
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

🔗 Requested URL: ${options.method} ${options.uri}      
📌 Headers: ${jsonEncode(options.headers)}  
📝 Body: ${options.headers["Content-Type"] == "application/json" ? jsonEncode(options.data) : options.data?.fields}  

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
""");
    }
  } catch (e) {
    errorLog(e, source: "API Request Info");
  }
}

void apiResponseLog(Response response, Stopwatch stopwatch) {
  var logger = Logger(printer: GreenPrinter());

  try {
    if (kDebugMode) {
      logger.i("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ==========> ✅️🎉💪🎯🥇 API Response Info ✅️🎉💪🎯🥇
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

⏳ Response Time: ${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)} sec      
📌 Status Code: ${response.statusCode}      
🔗 Requested URL: ${response.requestOptions.uri}      
📄 Data: ${response.data.toString()}  

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
""");
    }
  } catch (e) {
    errorLog(e, source: "API Response Info");
  }
}

void apiErrorLog(DioException error, Stopwatch stopwatch) {
  var logger = Logger(printer: PrettyPrinter());

  try {
    if (kDebugMode) {
      logger.e("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ==========> ❌⚠️🚫🛑 API Error Info ❌⚠️🚫🛑
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

⏳ Response Time: ${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)} sec      
📌 Status Code: ${error.response?.statusCode ?? "Unknown"}      
🔗 Requested URL: ${error.requestOptions.uri}      
❌ Error Data: ${jsonEncode(error.response?.data)}  

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
""");
    }
  } catch (e) {
    errorLog(e, source: "API Error Info");
  }
}


class GreenPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    const String green = '\x1B[32m';
    const String reset = '\x1B[0m';
    return ['$green${event.message}$reset'];
  }
}

class YellowPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    const String yellow = '\x1B[33m'; // ANSI Yellow Color
    const String reset = '\x1B[0m'; // Reset Color
    return ['$yellow${event.message}$reset'];
  }
}
