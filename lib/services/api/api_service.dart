import 'dart:async';
import 'package:dio/dio.dart';
import './api_response_model.dart';
import './config.dart';
import './api_response_handler.dart';
import './multipart_helper.dart';

class ApiService {
  static final Dio _dio = DioConfig.create();

  /// ================= HTTP METHODS =================

  static Future<ApiResponseModel> get(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) => _request(url, method: 'GET', headers: headers);

  static Future<ApiResponseModel> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) => _request(url, method: 'POST', body: body, headers: headers);

  static Future<ApiResponseModel> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) => _request(url, method: 'PUT', body: body, headers: headers);

  static Future<ApiResponseModel> patch(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) => _request(url, method: 'PATCH', body: body, headers: headers);

  static Future<ApiResponseModel> delete(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) => _request(url, method: 'DELETE', body: body, headers: headers);

  /// ================= MULTIPART =================

  static Future<ApiResponseModel> multipart({
    required String url,
    List<MultipartFileItem> files = const [],
    Map<String, String> body = const {},
    String method = 'POST',
    Map<String, String>? headers,
  }) async {
    final formData = await MultipartHelper.build(files: files, fields: body);
    return _request(url, method: method, body: formData, headers: headers);
  }

  /// ================= CORE REQUEST =================

  static Future<ApiResponseModel> _request(
    String url, {
    required String method,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: headers),
      );

      return ApiResponseHandler.handleSuccess(response);
    } catch (e) {
      return ApiResponseHandler.handleError(e);
    }
  }
}
