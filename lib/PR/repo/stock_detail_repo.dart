import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class StockDetailRepo {
  Future<ListResponse<StockDetail>> pull({List<int> stockIds}) async {
    var params = {"stock_ids": stockIds};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_STOCK_DETAIL, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<StockDetail>.from(
                response["data"].map((it) => StockDetail.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullStockDetail" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<StockDetail>> add(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? StockDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushStockDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<StockDetail>> update(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? StockDetail.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateStockDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<StockDetail>> delete(int id) async {
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
      print("$runtimeType status: delStockDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
