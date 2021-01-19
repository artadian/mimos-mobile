import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/brand_competitor.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/introdeal.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_price.dart';
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
      Response res =
          await client.get(API.URL_PULL_LOOKUP_PR, queryParameters: params);
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

  Future<ListResponse<Introdeal>> pullIntrodealPR(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res =
          await client.get(API.URL_PULL_INTRODEAL_PR, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Introdeal>.from(
                response["data"].map((it) => Introdeal.fromJson(it)))
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

  Future<ListResponse<BrandCompetitor>> pullBrandCompetitorPR(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_BRAND_COMPETITOR_PR,
          queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<BrandCompetitor>.from(
                response["data"].map((it) => BrandCompetitor.fromJson(it)))
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
}
