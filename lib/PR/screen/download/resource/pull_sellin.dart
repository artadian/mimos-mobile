import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/download_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullSellin {
  var _sellinDao = SellinDao();
  var _sellinDetailDao = SellinDetailDao();
  var _repo = DownloadRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Penjualan";
    model.tag = DOWNLOAD_TAG.SELLIN;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.shopping_cart;
    model.color = Colors.blue;
    model.countData = await _sellinDao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var resSellin = await pullSellin(date: date);

    if(resSellin.status){
      var resSellinDetail = await pullSellinDetail();
      yield await _success(resSellin);
    }else{
      yield _failed(resSellin.message);
    }

  }

  Future<ListResponse> pullSellin({@required String date}) async {
    var response = await _repo.pullSellin(userId: session.userId(), date: date);

    if (response.status) {
      if (response.list != null) {
        _sellinDao.truncate();
        _sellinDao.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullSellinDetail() async {
    var sellinIds = await _sellinDao.getAllPrimaryKey();
    var response = await _repo.pullSellinDetail(
      sellinIds: sellinIds,
    );

    if (response.status) {
      if (response.list != null) {
        _sellinDetailDao.truncate();
        _sellinDetailDao.insertAll(response.list);

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
    _model.countData = await _sellinDao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
