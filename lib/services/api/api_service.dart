import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/services/storage/storage_services.dart';
import 'package:flutter_boilerplate/utils/log/app_log.dart';
import 'package:flutter_boilerplate/utils/log/error_log.dart';

import '../../data/models/api_response_model.dart';
import '../../utils/constants/app_string.dart';

class ApiService {
  static final Dio _dio = getMyDio();

  /// ===================>for formData

  // FormData formData = FormData.fromMap({
  //   "file": await MultipartFile.fromFile(image!, filename: "naimul.png"),
  //   "name" : "naimul Hassan"
  // });
  //
  // var headers = {"Content-Type": "multipart/form-data"};

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    return requestApi(url, "POST", body: body, header: header);
  }

  static Future<ApiResponseModel> getApi(String url,
      {Map<String, String>? header}) async {
    return requestApi(url, "GET", header: header);
  }

  static Future<ApiResponseModel> putApi(String url,
      {Map<String, dynamic>? body, Map<String, String>? header}) async {
    return requestApi(url, "PUT", body: body, header: header);
  }

  static Future<ApiResponseModel> patchApi(String url,
      {body, Map<String, String>? header}) async {
    return requestApi(url, "PATCH", body: body, header: header);
  }

  static Future<ApiResponseModel> deleteApi(String url,
      {Map<String, dynamic>? body, Map<String, String>? header}) async {
    return requestApi(url, "DELETE", body: body, header: header);
  }

  static Future<ApiResponseModel> requestApi(
    String url,
    String method, {
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      Response response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: header),
      );
      return handleResponse(response);
    } catch (e) {
      return handleError(e);
    }
  }

  static ApiResponseModel handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(
          200, response.data['message'] ?? "", response.data);
    }

    return ApiResponseModel(response.statusCode ?? 500,
        response.data['message'] ?? "", response.data);
  }

  static ApiResponseModel handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 502) {
        return ApiResponseModel(502, "bad Gateway", {});
      }
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return ApiResponseModel(408, AppString.requestTimeOut, {});
        case DioExceptionType.connectionError:
          return ApiResponseModel(503, AppString.noInternetConnection, {});
        default:
          return ApiResponseModel(
              error.response?.statusCode ?? 500,
              error.response?.data?['message'] ??
                  error.message ??
                  "Unknown Error",
              {});
      }
    } else if (error is SocketException) {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } else if (error is FormatException) {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } else if (error is TimeoutException) {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } else {
      return ApiResponseModel(400, error.toString(), {});
    }
  }
}

Dio getMyDio() {
  Dio dio = Dio();
  Stopwatch stopwatch = Stopwatch();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers["Authorization"] =
          options.headers["Authorization"] ?? "Bearer ${LocalStorage.token}";
      options.headers["Content-Type"] =
          options.headers["Content-Type"] ?? "application/json";
      options.sendTimeout = const Duration(seconds: 30);
      options.receiveTimeout = const Duration(seconds: 30);
      stopwatch.start();
      appLog("${options.method}:${options.uri}",
          source: "Api Service", title: "Requested URL");
      appLog("${options.headers}",
          source: "Api Service", title: "Request Headers");
      if (options.headers["Content-Type"] == "application/json") {
        appLog(" ${jsonEncode(options.data)}",
            source: "Api Service", title: "Request Body");
      }

      handler.next(options);
    },
    onResponse: (response, handler) {
      stopwatch.stop();
      appLog("${stopwatch.elapsedMilliseconds / 1000} Second",
          source: "Api Service", title: "Response Time");
      appLog(" ${response.statusCode} ${response.requestOptions.uri}",
          source: "Api Service", title: "Response Status Code");
      appLog(jsonEncode(response.data),
          source: "Api Service", title: "Response Data");
      stopwatch.reset();

      handler.next(response);
    },
    onError: (error, handler) {
      stopwatch.stop();
      errorLog("${stopwatch.elapsedMilliseconds / 1000} Second",
          source: "Api Service", title: "Response Time");
      errorLog("${error.response?.statusCode} ${error.requestOptions.uri}",
          source: "Api Service", title: "Error Status Code");
      errorLog(" ${jsonEncode(error.response?.data)}",
          source: "Api Service", title: "Error Data");
      stopwatch.reset();

      handler.next(error);
    },
  ));
  return dio;
}
