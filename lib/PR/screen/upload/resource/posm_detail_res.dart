import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/model/default/upload_data.dart';
import 'package:mimos/PR/model/default/upload_model.dart';
import 'package:mimos/PR/repo/posm_detail_repo.dart';

class PosmDetailRes {
  var _dao = PosmDetailDao();
  var _repo = PosmDetailRepo();
  var _model = UploadModel(
    title: "Posm Detail",
    tag: UPLOAD_TAG.POSM_DETAIL,
    group: UPLOAD_TAG.POSM,
    status: UPLOAD_STATUS.INITIAL,
    icon: Icons.source,
    color: Colors.red,
    message: "Initial",
  );

  Future<UploadModel> init() async {
    if(await _dao.isNeedSyncOnly()){
      _model.status = UPLOAD_STATUS.NEED_SYNC;
      _model.message = "Data belum di upload";
    }else{
      _model.status = UPLOAD_STATUS.DONE;
      _model.message = "Complete";
    }
    return _model;
  }

  Future<bool> needSync() async {
    return await _dao.isNeedSync();
  }

  Stream<UploadModel> insert() async* {
    var type = UPLOAD_TYPE.INSERT;
    yield _loading(type);

    var listData = await _dao.needSync();

    if (listData.isEmpty) {
      yield _empty(type);
      return;
    }

    var results = List<UploadData>();

    for(var x in listData){
      var data = UploadData(status: false, type: _model.getType());

      var listData = await _dao.needSync();
      var row = listData.first;

      try {
        var res = await _repo.add(row);

        if (res.status) {
          await _dao.delete(row["id"], local: true);

          var dataExist = await _dao.getById(res.data.id);
          if(dataExist != null){
            // INSERT Data Existing
            dataExist.id = null; // Set ID to NULL, New Insert
            var idex = await _dao.insert(dataExist);
          }

          // INSERT Data From SERVER
          var id = await _dao.insert(res.data);

          data.status = true;
          data.message = res.message;
        } else {
          data.message = res.message;
        }
      } catch (e) {
        data.message = "Error Catch: $e";
        print("$runtimeType uploadInsert ERROR: $e");
      }
      results.add(data);
    }

    var success = results.indexWhere((e) => e.status == false) == -1;

    if (success) {
      yield _success(type);
    } else {
      yield _failed(type);
    }
  }

  Stream<UploadModel> update() async* {
    var type = UPLOAD_TYPE.UPDATE;
    yield _loading(type);

    var listData = await _dao.needUpdate();

    if (listData.isEmpty) {
      yield _empty(type);
      return;
    }

    var results = List<UploadData>();
    await Future.wait(listData.map((row) async {
      var data = UploadData(status: false, type: _model.getType());
      try {
        var res = await _repo.update(row);

        if (res.status) {
          await _dao.resetNeedUpdate(row["id"]);

          data.status = true;
          data.message = res.message;
        } else {
          data.message = res.message;
        }
      } catch (e) {
        data.message = "Error Catch: $e";
        print("$runtimeType uploadUpdate ERROR: $e");
      }
      results.add(data);
    }));

    var success = results.indexWhere((e) => e.status == false) == -1;

    if (success) {
      yield _success(type);
    } else {
      yield _failed(type);
    }
  }

  Stream<UploadModel> delete() async* {
    var type = UPLOAD_TYPE.DELETE;
    yield _loading(type);

    var listData = await _dao.needDeleteId();

    if (listData.isEmpty) {
      yield _empty(type);
      return;
    }

    var results = List<UploadData>();
    await Future.wait(listData.map((id) async {
      var data = UploadData(status: false, type: _model.getType());
      try {
        var res = await _repo.delete(id);

        if (res.status) {
          await _dao.delete(id, local: true);

          data.status = true;
          data.message = res.message;
        } else {
          data.message = res.message;
        }
      } catch (e) {
        data.message = "Error Catch: $e";
        print("$runtimeType uploadDelete ERROR: $e");
      }
      results.add(data);
    }));

    var success = results.indexWhere((e) => e.status == false) == -1;

    if (success) {
      yield _success(type);
    } else {
      yield _failed(type);
    }
  }

  UploadModel _loading(UPLOAD_TYPE type) {
    _model.status = UPLOAD_STATUS.LOADING;
    _model.type = type;
    _model.message = "Uploading, Please wait...";
    return _model;
  }

  UploadModel _empty(UPLOAD_TYPE type) {
    _model.type = type;
    _model.status = UPLOAD_STATUS.EMPTY;
    _model.message = "Data sudah Synchrone";
    return _model;
  }

  UploadModel _success(UPLOAD_TYPE type) {
    _model.type = type;
    _model.status = UPLOAD_STATUS.SUCCESS;
    _model.message =
    "${_model.getTag()}, ${_model.getType()} = ${_model.getStatus()}";
    return _model;
  }

  UploadModel _failed(UPLOAD_TYPE type) {
    _model.type = type;
    _model.status = UPLOAD_STATUS.FAILED;
    _model.message =
    "${_model.getTag()}, ${_model.getType()} = ${_model.getStatus()}";
    return _model;
  }
}
