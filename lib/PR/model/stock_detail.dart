import 'package:mimos/helper/extension.dart';

class StockDetail {
  int id;
  int stockid;
  String materialid;
  int bal;
  int slof;
  int pac;
  int qty;

  StockDetail.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        stockid = map["stockid"].toString().toInt(),
        materialid = map["materialid"].toString().clean(),
        bal = map["bal"].toString().toInt(),
        slof = map["slof"].toString().toInt(),
        pac = map["pac"].toString().toInt(),
        qty = map["qty"].toString().toInt();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['stockid'] = stockid;
    data['materialid'] = materialid;
    data['bal'] = bal;
    data['slof'] = slof;
    data['pac'] = pac;
    data['qty'] = qty;
    return data;
  }
}
