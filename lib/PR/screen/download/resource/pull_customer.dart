import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/customer_wsp_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/customer_wsp.dart';
import 'package:mimos/PR/repo/master_data_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullCustomer {
  var _dao = CustomerPRDao();
  var _repo = MasterDataRepo();
  var _daoCustWsp = CustomerWspDao();
  var _repoCustWsp = CustomerWspRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Customer";
    model.tag = DOWNLOAD_TAG.CUSTOMER;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.person;
    model.color = Colors.red;
    model.countData = await _dao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var res = await pullCustomer(date: date);

    if(res.status){
      var custWsp = await pullCustomerWsp();
      yield await _success(res);
    }else{
      yield _failed(res.message);
    }

  }

  // Stream<DownloadModel> pullCustomer({@required String date}) async* {
  //   _model = await init();
  //   yield _loading();
  //
  //   var response = await _repo.pullCustomerPR(
  //     userId: await session.getUserId(),
  //     date: date,
  //   );
  //
  //   if (response.status) {
  //     _dao.truncate();
  //     _dao.insertAll(response.list);
  //     print("$runtimeType: ${response.message}");
  //
  //     yield await _success(response);
  //   } else {
  //     print("$runtimeType: ${response.message}");
  //
  //     yield _failed(response.message);
  //   }
  // }

  Future<ListResponse> pullCustomer({@required String date}) async {
    var response = await _repo.pullCustomerPR(
      userId: await session.getUserId(),
      date: date,
    );

    if (response.status) {
      if (response.list != null) {
        _dao.truncate();
        _dao.insertAll(response.list);
        print("$runtimeType: ${response.message}");

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullCustomerWsp() async {
    var response = await _repoCustWsp.pull(
      customernos: await _dao.getAllCustomerno(),
    );

    if (response.status) {
      if (response.list != null) {
        _daoCustWsp.truncate();
        _daoCustWsp.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  /// UPDATE STATUS DOWNLOAD
  DownloadModel _loading() {
    _model.status = DOWNLOAD_STATUS.LOADING;
    return _model;
  }

  Future<DownloadModel> _success(ListResponse response) async {
    _model.status = DOWNLOAD_STATUS.SUCCESS;
    _model.message = response.message;
    _model.countData = await _dao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
