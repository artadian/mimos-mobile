import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/brand_competitor_pr.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/introdeal_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_pr.dart';
import 'package:mimos/PR/model/material_price_pr.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class DownloadRepo {
  Future<ListResponse<MaterialPR>> pullMaterialPR(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_MATERIAL_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<MaterialPR>.from(
                response["data"].map((it) => MaterialPR.fromJson(it)))
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullMaterialPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

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
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullCustomerPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<Lookup>> pullLookup(
      {String userId}) async {
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
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullLookupPR" + e.toString());
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
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullLookupPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<BrandCompetitorPR>> pullBrandCompetitorPR(
      {String salesOfficeId}) async {
    var params = {"salesofficeid": salesOfficeId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_BRAND_COMPETITOR_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<BrandCompetitorPR>.from(
            response["data"].map((it) => BrandCompetitorPR.fromJson(it)))
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullLookupPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<MaterialPricePR>> pullMaterialPricePR(
      {String userId, String date}) async {
    var params = {"userid": userId, "tglawal": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_MATERIAL_PRICE_PR, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<MaterialPricePR>.from(
            response["data"].map((it) => MaterialPricePR.fromJson(it)))
            : [];
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullLookupPR" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }
}
