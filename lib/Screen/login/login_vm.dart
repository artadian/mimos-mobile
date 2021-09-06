import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/PR/model/response/base_response.dart';
import 'package:mimos/PR/model/user.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/network/api/api_client.dart';
import 'package:mimos/network/api/api_service.dart' as API;

class LoginVM with ChangeNotifier {
  BuildContext context;
  // Form
  final keyForm = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var autovalidateMode = AutovalidateMode.disabled;
  var obscurePass = true;
  var loading = false;

  init(BuildContext context) async {
    this.context = context;
  }

  togglePass() {
    obscurePass = !obscurePass;
    notifyListeners();
  }

  setForm() {
    username.text = "test2@gmail.com";
    password.text = "12345";
  }

  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  signin() async {
    setLoading(true);
    var authProv = AuthProv();
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      var res = await authProv.login(
          username: username.text, password: password.text);
      if (res.status) {
        await session.createSession(res.data, password.text);
        Navigator.of(context).pushNamed(HOME_SCREEN);
      } else {
        setLoading(false);
      }
    } else {
      setLoading(false);
    }
  }
}

class AuthProv {
  Future<BaseResponse<User>> login({String username, String password}) async {
    var params = {"username": username, "password": password};
    print("$runtimeType params: $params");
    try {
      Response res = await client.post(API.URL_LOGIN, data: params);
      print("$runtimeType status: " + res.toString());

      var response = json.decode(res.toString());
      if (response["status"]) {
        var data =
            response['data'] != null ? User.fromJson(response['data']) : null;
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
