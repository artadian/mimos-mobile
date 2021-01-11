import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/visibility_detail_repo.dart';
import 'package:mimos/PR/repo/visibility_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullVisibility {
  var _visibilityDao = VisibilityDao();
  var _visibilityDetailDao = VisibilityDetailDao();
  var _visibilityRepo = VisibilityRepo();
  var _visibilityDetailRepo = VisibilityDetailRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Display";
    model.tag = DOWNLOAD_TAG.VISIBILITY;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.airplay;
    model.color = Colors.deepPurpleAccent;
    model.countData = await _visibilityDao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var resVisibility = await pullVisibility(date: date);

    if(resVisibility.status){
      var resVisibilityDetail = await pullVisibilityDetail();
      yield await _success(resVisibility);
    }else{
      yield _failed(resVisibility.message);
    }

  }

  Future<ListResponse> pullVisibility({@required String date}) async {
    var response = await _visibilityRepo.pull(userId: session.userId(), date: date);

    if (response.status) {
      if (response.list != null) {
        _visibilityDao.truncate();
        _visibilityDao.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullVisibilityDetail() async {
    var visibilityIds = await _visibilityDao.getAllPrimaryKey();
    var response = await _visibilityDetailRepo.pull(
      visibilityIds: visibilityIds,
    );

    if (response.status) {
      if (response.list != null) {
        _visibilityDetailDao.truncate();
        _visibilityDetailDao.insertAll(response.list);

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
    _model.countData = await _visibilityDao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
