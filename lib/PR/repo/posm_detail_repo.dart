import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class PosmDetailRepo {
  Future<ListResponse<PosmDetail>> pull({List<int> posmIds}) async {
    var params = {"posm_ids": posmIds};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_POSM_DETAIL, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<PosmDetail>.from(
                response["data"].map((it) => PosmDetail.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullPOSMDetail" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<PosmDetail>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? PosmDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushPosmDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<PosmDetail>> update(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? PosmDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updatePosmDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<PosmDetail>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res =
          await client.delete(API.URL_DELETE_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delPosmDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
