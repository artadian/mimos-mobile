import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/model/response/list_response.dart';
import 'package:mimos/PR/repo/stock_detail_repo.dart';
import 'package:mimos/PR/repo/stock_repo.dart';
import 'package:mimos/helper/session_manager.dart';

class PullStock {
  var _stockDao = StockDao();
  var _stockDetailDao = StockDetailDao();
  var _stockRepo = StockRepo();
  var _stockDetailRepo = StockDetailRepo();
  var _model = DownloadModel();

  Future<DownloadModel> init() async {
    var model = DownloadModel();
    model.title = "Stock";
    model.tag = DOWNLOAD_TAG.STOCK;
    model.status = DOWNLOAD_STATUS.INITIAL;
    model.icon = Icons.widgets;
    model.color = Colors.orange;
    model.countData = await _stockDao.count();
    return model;
  }

  Stream<DownloadModel> download({@required String date}) async* {
    _model = await init();
    yield _loading();

    var resStock = await pullStock(date: date);

    if(resStock.status){
      var resStockDetail = await pullStockDetail();
      yield await _success(resStock);
    }else{
      yield _failed(resStock.message);
    }

  }

  Future<ListResponse> pullStock({@required String date}) async {
    var response = await _stockRepo.pull(userId: session.userId(), date: date);

    if (response.status) {
      if (response.list != null) {
        _stockDao.truncate();
        _stockDao.insertAll(response.list);

        return response;
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<ListResponse> pullStockDetail() async {
    var stockIds = await _stockDao.getAllPrimaryKey();
    var response = await _stockDetailRepo.pull(
      stockIds: stockIds,
    );

    if (response.status) {
      if (response.list != null) {
        _stockDetailDao.truncate();
        _stockDetailDao.insertAll(response.list);

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
    _model.countData = await _stockDao.count();
    return _model;
  }

  DownloadModel _failed(String message) {
    _model.status = DOWNLOAD_STATUS.FAILED;
    _model.message = message;
    return _model;
  }
}
