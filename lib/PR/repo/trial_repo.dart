import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class TrialRepo {
  Future<ListResponse<Trial>> pull(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_TRIAL, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Trial>.from(
            response["data"].map((it) => Trial.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullTrial" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }
  
  Future<BaseResponse<Trial>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_TRIAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? Trial.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushTrial" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<Trial>> update(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_TRIAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? Trial.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateTrial" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<Trial>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res = await client.delete(API.URL_DELETE_TRIAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delTrial" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
