import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/customer_introdeal_dao.dart';
import 'package:mimos/PR/dao/introdeal_pr_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/download_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullIntrodeal {
  var _introdealDao = IntrodealPRDao();
  var _custIntrodealDao = CustomerIntrodealDao();
  var _repo = DownloadRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Introdeal";
    model.tag = DOWNLOAD_TAG.INTRODEAL;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.assignment_turned_in;
    model.color = Colors.orange;
    model.countData = await _introdealDao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var resSellin = await pullIntrodeal(date: date);

    if(resSellin.status){
      var custIntrodeal = await pullCustomerIntrodeal(date: date);
      yield await _success(resSellin);
    }else{
      yield _failed(resSellin.message);
    }

  }

  Future<ListResponse> pullIntrodeal({@required String date}) async {
    var response = await _repo.pullIntrodealPR(
      userId: session.userId(),
      date: date,
    );

    if (response.status) {
      if (response.list != null) {
        _introdealDao.truncate();
        _introdealDao.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullCustomerIntrodeal({@required String date}) async {
    var response = await _repo.pullCustomerIntrodeal(
      userId: session.userId(),
      date: date,
    );

    if (response.status) {
      if (response.list != null) {
        _custIntrodealDao.truncate();
        _custIntrodealDao.insertAll(response.list);

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
    _model.countData = await _introdealDao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
