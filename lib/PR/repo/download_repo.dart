import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/model/brand_competitor_pr.dart';
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/introdeal_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_pr.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/material_price_pr.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:mimos/PR/model/visit.dart';
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
            : null;
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
      Response res = await client.post(API.URL_PULL_BRAND_COMPETITOR_PR, data: params);
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
      Response res = await client.get(API.URL_PULL_MATERIAL_PRICE, queryParameters: params);
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
      Response res = await client.get(API.URL_PULL_CUST_INTRODEAL, queryParameters: params);
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

  // Visit
  Future<ListResponse<Visit>> pullVisit(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_VISIT, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Visit>.from(
            response["data"].map((it) => Visit.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullVisit" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  // Stock
  Future<ListResponse<Stock>> pullStock(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_STOCK, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Stock>.from(
            response["data"].map((it) => Stock.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullStock" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<StockDetail>> pullStockDetail(
      {List<int> stockIds}) async {
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

  // Sellin
  Future<ListResponse<Sellin>> pullSellin(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_SELLIN, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Sellin>.from(
            response["data"].map((it) => Sellin.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullSellin" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<SellinDetail>> pullSellinDetail(
      {List<int> sellinIds}) async {
    var params = {"sellin_ids": sellinIds};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_SELLIN_DETAIL, data: params);
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

  // Visibility
  Future<ListResponse<VisibilityModel>> pullVisibility(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_VISIBILITY, queryParameters: params);
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

  Future<ListResponse<VisibilityDetail>> pullVisibilityDetail(
      {List<int> visibilityIds}) async {
    var params = {"visibility_ids": visibilityIds};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_VISIBILITY_DETAIL, data: params);
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

  // POSM
  Future<ListResponse<Posm>> pullPOSM(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_POSM, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Posm>.from(
            response["data"].map((it) => Posm.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullPOSM" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  Future<ListResponse<PosmDetail>> pullPOSMDetail(
      {List<int> posmIds}) async {
    var params = {"posm_ids": posmIds};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_PULL_POSM_DETAIL, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<PosmDetail>.from(
            response["data"].map((it) => PosmDetail.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullPOSMDetail" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

  // TRIAL
  Future<ListResponse<Trial>> pullTrial(
      {String userId, String date}) async {
    var params = {"userid": userId, "tgl": date};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_PULL_TRIAL, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response["data"] != null
            ? List<Trial>.from(
            response["data"].map((it) => Posm.fromJson(it)))
            : null;
        return ListResponse.success(response: response, list: data);
      } else {
        return ListResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: pullTrial" + e.toString());
      return ListResponse.dioError(error: e);
    }
  }

}
