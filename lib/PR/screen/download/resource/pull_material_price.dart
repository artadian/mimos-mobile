import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/download_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullMaterialPrice {
  var _dao = MaterialPriceDao();
  var _repo = DownloadRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Material Price";
    model.tag = DOWNLOAD_TAG.MATERIAL_PRICE;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.ad_units;
    model.color = Colors.cyan;
    model.countData = await _dao.count();
    return model;
  }

  Stream<DownloadModel> download() async* {
    _model = await init();
    yield _loading();

    var response = await _repo.pullMaterialPrice(
      salesOfficeId: session.salesOfficeId(),
    );

    if (response.status) {
      _dao.truncate();
      _dao.insertAll(response.list);
      print("$runtimeType: ${response.message}");

      yield await _success(response);
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
