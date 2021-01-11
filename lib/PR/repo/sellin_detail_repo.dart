import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class SellinDetailRepo {
  Future<ListResponse<SellinDetail>> pull({List<int> sellinIds}) async {
    var params = {"sellin_ids": sellinIds};
    print("$runtimeType params: $params");
    try {
      Response res =
          await client.post(API.URL_PULL_SELLIN_DETAIL, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<SellinDetail>.from(
                response["data"].map((it) => SellinDetail.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullSellinDetail" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<SellinDetail>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_SELLIN_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? SellinDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushSellinDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<SellinDetail>> update(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_SELLIN_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? SellinDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateSellinDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<SellinDetail>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res =
          await client.delete(API.URL_DELETE_SELLIN_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delSellinDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}