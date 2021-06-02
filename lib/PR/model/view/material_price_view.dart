import 'package:mimos/helper/extension.dart';

class MaterialPriceView {
  int id;
  String materialname;
  String materialgroupid;
  int bal;
  int slof;
  int pac;
  int year;
  String materialpriceid;
  String materialid;
  String priceid;
  double price;
  String validfrom;
  String validto;
  String materialgroupname;
  String materialgroupdesc;
  int wsppac;
  int salesofficeid;

  MaterialPriceView({
    this.id,
    this.materialname,
    this.materialgroupid,
    this.bal,
    this.slof,
    this.pac,
    this.year,
    this.materialpriceid,
    this.materialid,
    this.priceid,
    this.price,
    this.validfrom,
    this.validto,
    this.materialgroupname,
    this.materialgroupdesc,
    this.wsppac,
    this.salesofficeid,
  });

  MaterialPriceView.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        materialname = map["materialname"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean(),
        bal = map["bal"].toString().toInt(),
        slof = map["slof"].toString().toInt(),
        pac = map["pac"].toString().toInt(),
        year = map["year"].toString().toInt(),
        materialpriceid = map["materialpriceid"].toString().clean(),
        materialid = map["materialid"].toString().clean(),
        priceid = map["priceid"].toString().clean(),
        price = map["price"].toString().toDouble(),
        validfrom = map["validfrom"].toString().clean(),
        validto = map["validto"].toString().clean(),
        materialgroupname = map["materialgroupname"].toString().clean(),
        materialgroupdesc = map["materialgroupdesc"].toString().clean(),
        wsppac = map["wsppac"].toString().toInt(),
        salesofficeid = map["salesofficeid"].toString().toInt();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['materialname'] = materialname;
    data['materialgroupid'] = materialgroupid;
    data['bal'] = bal;
    data['slof'] = slof;
    data['pac'] = pac;
    data['year'] = year;
    data['materialpriceid'] = materialpriceid;
    data['materialid'] = materialid;
    data['priceid'] = priceid;
    data['price'] = price;
    data['validfrom'] = validfrom;
    data['validto'] = validto;
    data['materialgroupname'] = materialgroupname;
    data['materialgroupdesc'] = materialgroupdesc;
    data['wsppac'] = wsppac;
    data['salesofficeid'] = salesofficeid;
    return data;
  }
}
