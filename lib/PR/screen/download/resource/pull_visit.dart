import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/visit_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullVisit {
  var _dao = VisitDao();
  var _repo = VisitRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Kunjungan";
    model.tag = DOWNLOAD_TAG.VISIT;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.assignment_turned_in;
    model.color = Colors.green;
    model.countData = await _dao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var response =
    await _repo.pull(userId: await session.getUserId(), date: date);

    if (response.status) {
      if (response.list != null) {
        _dao.truncate();
        _dao.insertAll(response.list);
        print("$runtimeType: ${response.message}");

        yield await _success(response);
      } else {
        yield await _success(response);
      }
    } else {
      print("$runtimeType: ${response.message}");

      yield _failed(response.message);
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
