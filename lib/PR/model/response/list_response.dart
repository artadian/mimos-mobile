import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mimos/helper/extension.dart';

class ListResponse<T> {
  bool status;
  String message;
  List<T> list;

  ListResponse.success(
      {@required Map<String, dynamic> response, List<T> list}) {
    this.status = response["status"].toString().toBool();
    this.message = response["message"].toString().clean();
    this.list = list;
  }

  ListResponse.failed({@required Map<String, dynamic> response}) {
    this.status = response["status"];
    this.message = response["message"].toString().clean();
  }

  ListResponse.unexpected({DioError error}) {
    this.status = false;
    this.message = error.message + ". " + error.response?.statusMessage ??
        error.error.toString();
  }

  ListResponse.dioError({DioError error}) {
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
