import 'package:mimos/helper/extension.dart';

class SellinDetail {
  int id;
  int sellinid;
  String materialid;
  String materialname;
  int bal;
  int slof;
  int pac;
  int qty;
  int qtyintrodeal;
  double price;
  double sellinvalue;
  bool needSync;
  bool isDelete;
  bool isLocal;

  SellinDetail({
    this.id,
    this.sellinid,
    this.materialid,
    this.materialname,
    this.bal,
    this.slof,
    this.pac,
    this.qty,
    this.qtyintrodeal,
    this.price,
    this.sellinvalue,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  SellinDetail.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        sellinid = map["sellinid"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        materialname = map["materialname"].toString().clean(),
        bal = map["bal"].toString().toInt(),
        slof = map["slof"].toString().toInt(),
        pac = map["pac"].toString().toInt(),
        qty = map["qty"].toString().toInt(),
        qtyintrodeal = map["qtyintrodeal"].toString().toInt(),
        price = map["price"].toString().toDouble(),
        sellinvalue = map["sellinvalue"].toString().toDouble(),
        needSync = map["needSync"].toString().toBool(),
        isDelete = map["isDelete"].toString().toBool(),
        isLocal = map["isLocal"].toString().toBool();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['sellinid'] = sellinid;
    data['materialid'] = materialid;
    data['materialname'] = materialname;
    data['bal'] = bal;
    data['slof'] = slof;
    data['pac'] = pac;
    data['qty'] = qty;
    data['qtyintrodeal'] = qtyintrodeal;
    data['price'] = price;
    data['sellinvalue'] = sellinvalue;
    data['needSync'] = needSync;
    data['isDelete'] = isDelete;
    data['isLocal'] = isLocal;
    return data;
  }
}
