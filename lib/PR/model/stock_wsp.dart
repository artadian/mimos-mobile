import 'package:mimos/helper/extension.dart';

class StockWsp {
  int id;
  int salesofficeid;
  String materialgroupidwsp;
  String wspclass;
  String materialgroupid;
  String materialgroupname;
  String materialgroupdesc;
  int pac;
  String startdate;
  String enddate;

  StockWsp({
    this.id,
    this.salesofficeid,
    this.materialgroupidwsp,
    this.wspclass,
    this.materialgroupid,
    this.materialgroupname,
    this.materialgroupdesc,
    this.pac,
    this.startdate,
    this.enddate,
  });

  StockWsp.fromJson(Map<String, dynamic> map)
      : id = map["id"].toString().toInt(),
        salesofficeid = map["salesofficeid"].toString().toInt(),
        materialgroupidwsp = map["materialgroupidwsp"].toString().clean(),
        wspclass = map["wspclass"].toString().clean(),
        materialgroupid = map["materialgroupid"].toString().clean(),
        materialgroupname = map["materialgroupname"].toString().clean(),
        materialgroupdesc = map["materialgroupdesc"].toString().clean(),
        pac = map["pac"].toString().toInt(),
        startdate = map["startdate"].toString().clean(),
        enddate = map["enddate"].toString().clean();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['salesofficeid'] = salesofficeid;
    data['materialgroupidwsp'] = materialgroupidwsp;
    data['wspclass'] = wspclass;
    data['materialgroupid'] = materialgroupid;
    data['materialgroupname'] = materialgroupname;
    data['materialgroupdesc'] = materialgroupdesc;
    data['pac'] = pac;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    return data;
  }
}
