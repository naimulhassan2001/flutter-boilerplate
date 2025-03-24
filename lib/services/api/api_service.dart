import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/services/storage/storage_services.dart';
import 'package:flutter_boilerplate/utils/constants/api_end_point.dart';
import 'package:mime/mime.dart';
import '../../data/models/api_response_model.dart';
import '../../utils/constants/app_string.dart';
import '../../utils/log/api_log.dart';

class ApiService {
  static final Dio _dio = _getMyDio();

  /// ========== [ HTTP METHODS ] ========== ///
  static Future<ApiResponseModel> post(String url, dynamic body,
          {Map<String, String>? header}) =>
      _request(url, "POST", body: body, header: header);

  static Future<ApiResponseModel> get(String url,
          {Map<String, String>? header}) =>
      _request(url, "GET", header: header);

  static Future<ApiResponseModel> put(String url,
          {dynamic body, Map<String, String>? header}) =>
      _request(url, "PUT", body: body, header: header);

  static Future<ApiResponseModel> patch(String url,
          {dynamic body, Map<String, String>? header}) =>
      _request(url, "PATCH", body: body, header: header);

  static Future<ApiResponseModel> delete(String url,
          {dynamic body, Map<String, String>? header}) =>
      _request(url, "DELETE", body: body, header: header);

  static Future<ApiResponseModel> multipart(
    String url, {
    Map<String, String> header = const {},
    Map<String, String> body = const {},
    String method = "POST",
    String imageName = 'image',
    String? imagePath,
  }) async {
    FormData formData = FormData();
    if (imagePath != null && imagePath.isNotEmpty) {
      File file = File(imagePath);
      String extension = file.path.split('.').last.toLowerCase();
      String? mimeType = lookupMimeType(imagePath);

      formData.files.add(MapEntry(
        imageName,
        await MultipartFile.fromFile(
          imagePath,
          filename: "$imageName.$extension",
          contentType: mimeType != null
              ? DioMediaType.parse(mimeType)
              : DioMediaType.parse("image/jpeg"),
        ),
      ));
    }

    body.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    header['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: header);
  }

  /// ========== [ API REQUEST HANDLER ] ========== ///
  static Future<ApiResponseModel> _request(
    String url,
    String method, {
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: header),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(
        200,
        response.data['message'] ?? "",
        response.data,
      );
    }
    return ApiResponseModel(
      response.statusCode ?? 500,
      response.data['message'] ?? "",
      response.data,
    );
  }

  static ApiResponseModel _handleError(dynamic error) {
    if (error is DioException) {
      // If the error is a DioException and has a response, handle it
      if (error.response != null) {
        switch (error.response!.statusCode) {
          case 502:
            return ApiResponseModel(
              502,
              "Bad Gateway",
              error.response!.data,
            );
          default:
            return ApiResponseModel(
              error.response?.statusCode ?? 500,
              error.response?.data?['message'] ??
                  error.message ??
                  "Unknown Error",
              error.response?.data ?? {},
            );
        }
      } else {
        // Handle DioException that doesn't have a response
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            return ApiResponseModel(408, AppString.requestTimeOut, {});
          case DioExceptionType.connectionError:
            return ApiResponseModel(503, AppString.noInternetConnection, {});
          default:
            return ApiResponseModel(
              500,
              "DioException without response",
              {},
            );
        }
      }
    } else if (error is SocketException) {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } else if (error is FormatException) {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } else if (error is TimeoutException) {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } else {
      // Default error handling when none of the above matches
      return ApiResponseModel(500, error.toString(), {});
    }
  }
}

/// ========== [ DIO INSTANCE WITH INTERCEPTORS ] ========== ///
Dio _getMyDio() {
  Dio dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final stopwatch = Stopwatch()..start();
      options
        ..headers["Authorization"] ??= "Bearer ${LocalStorage.token}"
        ..headers["Content-Type"] ??= "application/json"
        ..sendTimeout = const Duration(seconds: 30)
        ..receiveTimeout = const Duration(seconds: 30)
        ..baseUrl =
            options.baseUrl.startsWith("http") ? "" : ApiEndPoint.baseUrl
        ..extra["stopwatch"] = stopwatch;

      apiRequestLog(options);
      handler.next(options);
    },
    onResponse: (response, handler) {
      final stopwatch =
          response.requestOptions.extra["stopwatch"] as Stopwatch?;
      stopwatch?.stop();
      apiResponseLog(response, stopwatch ?? Stopwatch());
      handler.next(response);
    },
    onError: (error, handler) {
      final stopwatch = error.requestOptions.extra["stopwatch"] as Stopwatch?;
      stopwatch?.stop();
      apiErrorLog(error, stopwatch ?? Stopwatch());
      handler.next(error);
    },
  ));

  return dio;
}
