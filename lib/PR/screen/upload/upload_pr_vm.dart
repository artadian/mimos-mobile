import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/upload/resource/upload_posm_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_posm_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_sellin_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_sellin_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_stock_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_stock_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_visibility_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_visibility_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_visit_res.dart';

class UploadPRVM with ChangeNotifier {
  var _visitRes = UploadVisitRes();
  var _stockRes = UploadStockRes();
  var _stockDetailRes = UploadStockDetailRes();
  var _sellinRes = UploadSellinRes();
  var _sellinDetailRes = UploadSellinDetailRes();
  var _posmRes = UploadPosmRes();
  var _posmDetailRes = UploadPosmDetailRes();
  var _visibilityRes = UploadVisibilityRes();
  var _visibilityDetailRes = UploadVisibilityDetailRes();

  uploadVisit() async {
    var resVisit = await _visitRes.insert();
    var resStock = await _stockRes.insert();
    var resSellin = await _sellinRes.insert();
    var resPosm = await _posmRes.insert();
    var resVisibility = await _visibilityRes.insert();
    resVisit.forEach((element) {
      print("resVisit upload: $element");
    });
    resStock.forEach((element) {
      print("resStock upload: $element");
    });
    await syncInsert();
  }

  syncInsert() async {
    if (!await _stockRes.needSync()) {
      var res = await _stockDetailRes.insert();
    }
    if (!await _sellinRes.needSync()) {
      var res = await _sellinDetailRes.insert();
    }
    if (!await _posmRes.needSync()) {
      var res = await _posmRes.insert();
    }
    if (!await _visibilityRes.needSync()) {
      var res = await _visibilityRes.insert();
    }

    await syncUpdate();
    await syncDelete();
  }

  syncUpdate() async {
    var sellinUpdate = await _sellinRes.update();
    var stockDetailUpdate = await _stockDetailRes.update();
    var sellinDetailUpdate = await _sellinDetailRes.update();
    var posmDetailUpdate = await _posmDetailRes.update();
    var visibilityDetailUpdate = await _visibilityDetailRes.update();
  }

  syncDelete() async {
    var stockDetailDel = await _stockDetailRes.delete();
    var sellinDetailDel = await _sellinDetailRes.delete();
    var posmDetailDel = await _posmDetailRes.delete();
    var visibilityDetailDel = await _visibilityDetailRes.delete();
  }
}
