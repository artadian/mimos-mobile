import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/download_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullPosm {
  var _posmDao = PosmDao();
  var _posmDetailDao = PosmDetailDao();
  var _repo = DownloadRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "POSM";
    model.tag = DOWNLOAD_TAG.POSM;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.source;
    model.color = Colors.lime;
    model.countData = await _posmDao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var resPosm = await pullPosm(date: date);

    if(resPosm.status){
      var resPosmDetail = await pullPosmDetail();
      yield await _success(resPosm);
    }else{
      yield _failed(resPosm.message);
    }

  }

  Future<ListResponse> pullPosm({@required String date}) async {
    var response = await _repo.pullPOSM(userId: session.userId(), date: date);

    if (response.status) {
      if (response.list != null) {
        _posmDao.truncate();
        _posmDao.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullPosmDetail() async {
    var posmIds = await _posmDao.getAllPrimaryKey();
    var response = await _repo.pullPOSMDetail(
      posmIds: posmIds,
    );

    if (response.status) {
      if (response.list != null) {
        _posmDetailDao.truncate();
        _posmDetailDao.insertAll(response.list);

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
    _model.countData = await _posmDao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
