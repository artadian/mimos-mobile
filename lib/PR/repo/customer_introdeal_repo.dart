import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class CustomerIntrodealRepo {
  Future<ListResponse<CustomerIntrodeal>> pull({String userId}) async {
    var params = {"userid": userId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_CUST_INTRODEAL,
          queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<CustomerIntrodeal>.from(
                response["data"].map((it) => CustomerIntrodeal.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullCustomerIntrodeal" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<CustomerIntrodeal>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_CUST_INTRODEAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? CustomerIntrodeal.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushCustomerIntrodeal" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<CustomerIntrodeal>> update(
      Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_CUST_INTRODEAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? CustomerIntrodeal.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateCustomerIntrodeal" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<CustomerIntrodeal>> delete(int id) async {
    var data = {"id": id};
    print("$runtimeType datas: $data");
    try {
      Response res = await client.delete(API.URL_DELETE_CUST_INTRODEAL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        return BaseResponse.success(response: response);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: delCustomerIntrodeal" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
