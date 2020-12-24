import 'package:flutter/material.dart';
import 'package:mimos/PR/screen/upload/resource/upload_stock_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_stock_res.dart';
import 'package:mimos/PR/screen/upload/resource/upload_visit_res.dart';

class UploadPRVM with ChangeNotifier {
  var _visitRes = UploadVisitRes();
  var _stockRes = UploadStockRes();
  var _stockDetailRes = UploadStockDetailRes();

  uploadVisit() async {
    var resVisit = await _visitRes.insert();
    var resStock = await _stockRes.insert();
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
      var resStockD = await _stockDetailRes.insert();
    }

    await syncUpdate();
    await syncDelete();
  }

  syncUpdate() async {
    var stockDetailUpdate = await _stockDetailRes.update();
    var stockDetailDel = await _stockDetailRes.delete();
  }

  syncDelete() async {
    var stockDetailDel = await _stockDetailRes.delete();
  }

}