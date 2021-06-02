import 'package:flutter/cupertino.dart';
import 'package:mimos/helper/extension.dart';

class StockDetail {
  int id;
  int stockid;
  String materialid;
  String materialname;
  int bal;
  int slof;
  int pac;
  double qty;
  bool needSync;
  bool isDelete;
  bool isLocal;

  StockDetail({
    this.id,
    this.stockid,
    this.materialid,
    this.materialname,
    this.bal,
    this.slof,
    this.pac,
    this.qty,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  StockDetail.create({
    @required int stockid,
    @required String materialid,
    @required String materialname,
  })  : id = null,
        stockid = stockid,
        materialid = materialid,
        materialname = materialname,
        bal = 0,
        slof = 0,
        pac = 0,
        qty = 0,
        needSync = true,
        isDelete = false,
        isLocal = true;

  StockDetail.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        stockid = map["stockid"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        materialname = map["materialname"].toString().clean(),
        bal = map["bal"].toString().toInt(),
        slof = map["slof"].toString().toInt(),
        pac = map["pac"].toString().toInt(),
        qty = map["qty"].toString().toDouble(),
        needSync = map["needSync"].toString().toBool(),
        isDelete = map["isDelete"].toString().toBool(),
        isLocal = map["isLocal"].toString().toBool();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['stockid'] = stockid;
    data['materialid'] = materialid;
    data['materialname'] = materialname;
    data['bal'] = bal;
    data['slof'] = slof;
    data['pac'] = pac;
    data['qty'] = qty;
    data['needSync'] = needSync;
    data['isDelete'] = isDelete;
    data['isLocal'] = isLocal;
    return data;
  }
}
