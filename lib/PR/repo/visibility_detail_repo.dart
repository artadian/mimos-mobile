import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class VisibilityDetailRepo {
  Future<ListResponse<VisibilityDetail>> pull({List<int> visibilityIds}) async {
    var params = {"visibility_ids": visibilityIds};
    print("$runtimeType params: $params");
    try {
      Response res =
          await client.post(API.URL_PULL_VISIBILITY_DETAIL, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<VisibilityDetail>.from(
                response["data"].map((it) => VisibilityDetail.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullVisibilityDetail" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityDetail>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res =
          await client.post(API.URL_PUSH_VISIBILITY_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? VisibilityDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushVisibilityDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityDetail>> update(
      Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res =
          await client.put(API.URL_UPDATE_VISIBILITY_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? VisibilityDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateVisibilityDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityDetail>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res =
          await client.delete(API.URL_DELETE_VISIBILITY_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delVisibilityDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
