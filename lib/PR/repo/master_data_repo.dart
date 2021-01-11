import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/brand_competitor_pr.dart';
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/introdeal_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class MasterDataRepo {
  Future<ListResponse<CustomerPR>> pullCustomerPR(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_CUSTOMER_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<CustomerPR>.from(
                response["data"].map((it) => CustomerPR.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullCustomerPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<Lookup>> pullLookup({String userId}) async {
    var params = {"userid": userId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_LOOKUP_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Lookup>.from(
                response["data"].map((it) => Lookup.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullLookup" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<IntrodealPR>> pullIntrodealPR(
      {String userId, String date}) async {
    var params = {"userid": userId, "tglawal": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_INTRODEAL_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<IntrodealPR>.from(
                response["data"].map((it) => IntrodealPR.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullIntrodealPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<BrandCompetitorPR>> pullBrandCompetitorPR(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res =
          await client.post(API.URL_PULL_BRAND_COMPETITOR_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<BrandCompetitorPR>.from(
                response["data"].map((it) => BrandCompetitorPR.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullBrandCompetitorPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<MaterialPrice>> pullMaterialPrice(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_MATERIAL_PRICE,
          queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<MaterialPrice>.from(
                response["data"].map((it) => MaterialPrice.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullMaterialPrice" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<CustomerIntrodeal>> pullCustomerIntrodeal(
      {String userId, String date}) async {
    var params = {"userid": userId, "tglawal": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_CUST_INTRODEAL,
          queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<CustomerIntrodeal>.from(
                response["data"].map((it) => Posm.fromJson(it)))
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
}
