import 'package:mimos/helper/extension.dart';

class Introdeal {
  int id;
  String salesofficeid;
  String materialid;
  int qtyorder;
  int qtybonus;
  String startdate;
  String enddate;
  String materialname;
  String materialgroupid;

  Introdeal({
    this.id,
    this.salesofficeid,
    this.materialid,
    this.qtyorder,
    this.qtybonus,
    this.startdate,
    this.enddate,
    this.materialname,
    this.materialgroupid,
  });

  Introdeal.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        salesofficeid = map["salesofficeid"].toString().clean(),
        materialid = map["materialid"].toString().clean(),
        qtyorder = map["qtyorder"].toString().toInt(),
        qtybonus = map["qtybonus"].toString().toInt(),
        startdate = map["startdate"].toString().clean(),
        enddate = map["enddate"].toString().clean(),
        materialname = map["materialname"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['salesofficeid'] = salesofficeid;
    data['materialid'] = materialid;
    data['qtyorder'] = qtyorder;
    data['qtybonus'] = qtybonus;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['materialname'] = materialname;
    data['materialgroupid'] = materialgroupid;
    return data;
  }
}
