import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/visit.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class VisitRepo {
  Future<ListResponse<Visit>> pull(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_VISIT, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Visit>.from(
            response["data"].map((it) => Visit.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullVisit" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<Visit>> add(Map<String, dynamic> data) async {
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

  Future<BaseResponse<Visit>> update(Map<String, dynamic> data) async {
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
      print("$runtimeType status: updateVisit" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<Visit>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res = await client.delete(API.URL_DELETE_VISIT, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delVisit" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
