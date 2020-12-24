import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/visit.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class UploadVisitRepo {
  Future<BaseResponse<Visit>> pushVisit(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_VISIT, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? Visit.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushVisit" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<Visit>> updateVisit(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_UPDATE_VISIT, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? Visit.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushVisit" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
