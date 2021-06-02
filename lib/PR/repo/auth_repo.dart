import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mimos/PR/model/app_version.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class AuthRepo {
  Future<BaseResponse<AppVersion>> appVersion(String userId) async {
    var params = {"userid": userId};
    print("$runtimeType params: $params");
    try {
      Response res = await client.get(API.URL_APP_VERSION, queryParameters: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data = response['data'] != null
            ? AppVersion.fromJson(response['data'])
            : null;
        return BaseResponse.success(response: response, data: data);
      } else {
        return BaseResponse.failed(response: response);
      }
    } on DioError catch (e) {
      print("$runtimeType status: appVersion" + e.toString());
      return BaseResponse.dioError(error: e);
    }
  }
}
