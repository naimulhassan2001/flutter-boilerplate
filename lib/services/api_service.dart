import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/utils/app_string.dart';
import "package:http/http.dart" as http;

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../helpers/prefs_helper.dart';
import '../models/api_response_model.dart';

class ApiService {
  static const int timeOut = 30;

  ///<<<======================== Post Api ==============================>>>

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      'Accept-Language': PrefsHelper.localizationLanguageCode,
    };

    if (kDebugMode) {
      print("=======================================> url $mainHeader");
      print("==================================================> body $body");
      print("==================================================> url $url");
    }

    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }

    return responseJson;
  }

  ///<<<======================== Get Api ==============================>>>

  static Future<ApiResponseModel> getApi(String url,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      'Accept-Language': PrefsHelper.localizationLanguageCode
    };

    if (kDebugMode) {
      print("=======================================> url $mainHeader");
      print("==================================================> url $url");
    }

    try {
      final response = await http
          .get(Uri.parse(url), headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }
    return responseJson;
  }

  ///<<<======================== Put Api ==============================>>>

  static Future<ApiResponseModel> putApi(String url, Map<String, String> body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      'Accept-Language': PrefsHelper.localizationLanguageCode
    };

    if (kDebugMode) {
      print("=======================================> url $mainHeader");
      print("==================================================> body $body");
      print("==================================================> url $url");
    }

    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }
    return responseJson;
  }

  ///<<<======================== Patch Api ==============================>>>

  static Future<ApiResponseModel> patchApi(
    String url, {
    Map<String, String>? body,
    Map<String, String>? header,
  }) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      'Accept-Language': PrefsHelper.localizationLanguageCode
    };

    if (kDebugMode) {
      print("=======================================> url $mainHeader");
      print("==================================================> body $body");
      print("==================================================> url $url");
    }

    try {
      if (body != null) {
        final response = await http
            .patch(Uri.parse(url), body: body, headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .patch(Uri.parse(url), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }

    return responseJson;
  }

  ///<<<======================== Delete Api ==============================>>>

  static Future<ApiResponseModel> deleteApi(String url,
      {Map<String, String>? body, Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': "Bearer ${PrefsHelper.token}",
      'Accept-Language': PrefsHelper.localizationLanguageCode
    };

    if (kDebugMode) {
      print("=======================================> url $mainHeader");
      print("==================================================> body $body");
      print("==================================================> url $url");
    }

    try {
      if (body != null) {
        final response = await http
            .delete(Uri.parse(url), body: body, headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .delete(Uri.parse(url), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }
    return responseJson;
  }

  ///<<<================== Api Response Status Code Handle ====================>>>

  static dynamic handleResponse(http.Response response) {
    Map data = jsonDecode(response.body);

    if (kDebugMode) {
      print("========================> statusCode ${response.statusCode}");
      print("===============================> body $data");
    }

    switch (response.statusCode) {
      case 200:
        return ApiResponseModel(response.statusCode, data['message'], data);
      case 201:
        return ApiResponseModel(200, data['message'], data);
      case 401:
        // Get.offAllNamed(AppRoutes.signInScreen);
        return ApiResponseModel(response.statusCode, data['message'], data);
      case 400:
        return ApiResponseModel(response.statusCode, data['message'], data);
      case 404:
        return ApiResponseModel(response.statusCode, data['message'], data);
      default:
        return ApiResponseModel(response.statusCode, data['message'], data);
    }
  }

  ///<<<======================== multipartRequest Api ==============================>>>

  static Future<ApiResponseModel> multipartRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
    method = "POST",
    String? imagePath,
    imageName = 'image',
  }) async {
    try {
      Map<String, String> mainHeader = {
        'Authorization': "Bearer ${PrefsHelper.token}",
      };

      if (kDebugMode) {
        print("=================================================>url $url");
        print("===============================================>body $body");
        print("===========================>header ${header ?? mainHeader}");
        print("===========================>method $method");
        print("===========================>imagePath $imagePath");
        print("===========================>imageName $imageName");
      }

      var request = http.MultipartRequest(method, Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);
        var shopImage = await http.MultipartFile.fromPath(imageName, imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(shopImage);
      }

      Map<String, String> headers = header ?? mainHeader;

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var response = await request.send();

      if (kDebugMode) {
        print("========================>statusCode ${response.statusCode}");
      }

      String data = await response.stream.bytesToString();
      var mapData = jsonDecode(data);

      if (response.statusCode == 200) {
        return ApiResponseModel(200, mapData['message'], mapData);
      } else if (response.statusCode == 201) {
        return ApiResponseModel(200, mapData['message'], mapData);
      } else {
        return ApiResponseModel(
            response.statusCode, mapData['message'], mapData);
      }
    } on SocketException {
      return ApiResponseModel(503, AppString.noInternetConnection, {});
    } on FormatException {
      return ApiResponseModel(400, AppString.badResponseRequest, {});
    } on TimeoutException {
      return ApiResponseModel(408, AppString.requestTimeOut, {});
    } catch (e) {
      return ApiResponseModel(400, e.toString(), {});
    }
  }
}
