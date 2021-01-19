import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/customer_introdeal_dao.dart';
import 'package:mimos/PR/dao/introdeal_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/customer_introdeal_repo.dart';
import 'package:mimos/PR/repo/master_data_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullIntrodeal {
  var _introdealDao = IntrodealDao();
  var _custIntrodealDao = CustomerIntrodealDao();
  var _introdealRepo = MasterDataRepo();
  var _custIntrodealRepo = CustomerIntrodealRepo();
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
    var response = await _introdealRepo.pullIntrodealPR(
      salesOfficeId: session.salesOfficeId(),
    );

    if (response.status) {
      print("zain. ${response.list.length}");
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
    var response = await _custIntrodealRepo.pull(
      userId: await session.getUserId(),
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


