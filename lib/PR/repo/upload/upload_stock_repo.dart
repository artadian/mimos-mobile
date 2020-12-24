import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class UploadStockRepo {
  /// Stock Head
  Future<BaseResponse<Stock>> pushStock(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_STOCK, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? Stock.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushStock" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  /// Stock Detail
  Future<BaseResponse<StockDetail>> pushStockDetail(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.post(API.URL_PUSH_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? StockDetail.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pushStockDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<StockDetail>> updateStockDetail(Map<String, dynamic> data) async {
    print("$runtimeType datas: $data");
    try {
      Response res = await client.put(API.URL_UPDATE_STOCK_DETAIL, data: data);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
        response['data'] != null ? StockDetail.fromJson(response['data']) : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: updateStockDetail" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }

  Future<BaseResponse<StockDetail>> delStockDetail(int id) async {
    var datas = {"id": "108"};
    print("$runtimeType datas: $datas");
    try {
      Response res = await client.delete(API.URL_DELETE_STOCK_DETAIL, data: datas);
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
