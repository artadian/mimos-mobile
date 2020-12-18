import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/network/api/api_service.dart';


class ApiClient {
  static Dio _dio = Dio();
  static const connectTimeout = 15000;
  static const receiveTimeout = 15000;

  Dio instance() {
    if (_dio != null) return _dio;
    _dio = _initialize();
    return _dio;
  }

  static Dio dio() {
    Dio _dio = Dio();
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.contentType = ContentType.json.toString();
      options.connectTimeout = connectTimeout;
      options.receiveTimeout = receiveTimeout;

      return options;
    }, onResponse: (Response response) {
      try {
        response.data = removeAllHtml(response.data);
      } catch (e) {
        print("ApiClient: $e");
      }
      print("DioResponse: ${response.data}");
      return response;
    }, onError: (DioError e) {
      print("DioError: ${e.message}, ${e.response}");
      return e;
    }));

    return _dio;
  }

  Dio _initialize() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {

      options.baseUrl = BASE_URL_API;
      options.contentType = ContentType.json.toString();
      options.connectTimeout = connectTimeout;
      options.receiveTimeout = receiveTimeout;

      return options;
    }, onResponse: (Response response) {
      try {
        response.data = removeAllHtml(response.data);
      } catch (e) {
        print(e);
      }
      print("DioResponse: ${response.data}");
      return response;
    }, onError: (DioError e) {
      print("DioError: ${e.message}, ${e.response}");
      return e;
    }));

    return _dio;
  }

  static Map<String, dynamic> removeAllHtml(dynamic data) {
    try {
      RegExp exp = RegExp(r"<[^>].*>", multiLine: true, caseSensitive: true);
      var res = data.toString().replaceAll(exp, '');
      return json.decode(res);
    }catch(e){
      print("ApiClient: $e");
      return data;
    }
  }
}

final client = ApiClient().instance();
