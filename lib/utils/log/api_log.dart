
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'error_log.dart';


void apiRequestLog(RequestOptions options) {

  try {
    if (kDebugMode) {
      log("""
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

  try {
    if (kDebugMode) {
      log("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ==========> ✅️🎉💪🎯🥇 API Response Info ✅️🎉💪🎯🥇
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

⏳ Response Time: ${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)} sec      
📌 Status Code: ${response.statusCode}      
🔗 Response URL: ${response.requestOptions.uri}      
🔗 Response headers: ${response.headers}      
📄 Data: ${response.data.toString()}  

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
""");
    }
  } catch (e) {
    errorLog(e, source: "API Response Info");
  }
}

void apiErrorLog(DioException error, Stopwatch stopwatch) {

  try {
    if (kDebugMode) {
      log("""
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

