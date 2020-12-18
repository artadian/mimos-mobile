import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mimos/helper/extension.dart';

class BaseResponse<T> {
  bool status;
  String message;
  T data;

  BaseResponse.success({@required Map<String, dynamic> response, T data}) {
    this.status = response["status"];
    this.message = response["message"].toString().clean();
    this.data = data;
  }

  BaseResponse.failed({@required Map<String, dynamic> response}) {
    this.status = response["status"];
    this.message = response["message"].toString().clean();
  }

  BaseResponse.unexpected({DioError error}) {
    this.status = false;
    this.message = error.message + ". " + error.response?.statusMessage ??
        error.error.toString();
  }

  BaseResponse.dioError({DioError error}) {
    this.status = false;
    if (error.response != null &&
        error.response is Map<String, dynamic> &&
        error.response.data != null) {
      print("$runtimeType status: FAILED");
      this.message = error.response.data["message"].toString().clean();
    } else {
      print("$runtimeType status: UNEXPECTED");
      this.message = "${error.message}";
    }
  }
}
