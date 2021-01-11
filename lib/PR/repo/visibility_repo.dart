import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class VisibilityRepo {
  Future<ListResponse<VisibilityModel>> pull(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res =
          await client.get(API.URL_PULL_VISIBILITY, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<VisibilityModel>.from(
                response["data"].map((it) => VisibilityModel.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullVisibility" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityModel>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_VISIBILITY, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? VisibilityModel.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushVisibility" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityModel>> update(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_UPDATE_VISIBILITY, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? VisibilityModel.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateVisibility" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<VisibilityModel>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res = await client.delete(API.URL_DELETE_VISIBILITY, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delVisibility" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
