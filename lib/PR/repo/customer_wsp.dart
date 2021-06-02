import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/customer_wsp.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class CustomerWspRepo {
  Future<ListResponse<CustomerWsp>> pull({List<String> customernos}) async {
    var params = {"customernos": customernos};
    print("$runtimeType params: $params");
    try {
      Response res =
      await client.post(API.URL_PULL_CUSTOMER_WSP, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<CustomerWsp>.from(response["data"].map((it) => CustomerWsp.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullCustomerWsp" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

// Future<BaseResponse<StockWsp>> add(Map<String, dynamic> data) async {
//   print("$runtimeType datas: $data");
//   try {
//     Response res = await client.post(API.URL_PUSH_STOCK_WSP, data: data);
//     print("$runtimeType status: " + res.toString());
//
//     var response = json.decode(res.toString());
//     if (response["status"]) {
//       var data =
//       response['data'] != null ? StockWsp.fromJson(response['data']) : null;
//       return BaseResponse.success(response: response, data: data);
//     } else {
//       return BaseResponse.failed(response: response);
//     }
//   } on DioError catch (e) {
//     print("$runtimeType status: pushStockWsp" + e.toString());
//     return BaseResponse.dioError(error: e);
//   }
// }
//
// Future<BaseResponse<StockWsp>> update(Map<String, dynamic> data) async {
//   print("$runtimeType datas: $data");
//   try {
//     Response res = await client.post(API.URL_UPDATE_STOCK_WSP, data: data);
//     print("$runtimeType status: " + res.toString());
//
//     var response = json.decode(res.toString());
//     if (response["status"]) {
//       var data =
//       response['data'] != null ? StockWsp.fromJson(response['data']) : null;
//       return BaseResponse.success(response: response, data: data);
//     } else {
//       return BaseResponse.failed(response: response);
//     }
//   } on DioError catch (e) {
//     print("$runtimeType status: updateStockWsp" + e.toString());
//     return BaseResponse.dioError(error: e);
//   }
// }
//
// Future<BaseResponse<StockWsp>> delete(int id) async {
//   var data = {"id": id};
//   print("$runtimeType datas: $data");
//   try {
//     Response res = await client.delete(API.URL_DELETE_STOCK_WSP, data: data);
//     print("$runtimeType status: " + res.toString());
//
//     var response = json.decode(res.toString());
//     if (response["status"]) {
//       return BaseResponse.success(response: response);
//     } else {
//       return BaseResponse.failed(response: response);
//     }
//   } on DioError catch (e) {
//     print("$runtimeType status: delStockWsp" + e.toString());
//     return BaseResponse.dioError(error: e);
//   }
// }
}
