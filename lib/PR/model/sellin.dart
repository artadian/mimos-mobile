import 'package:mimos/helper/extension.dart';
import 'package:mimos/helper/session_manager.dart';

class Sellin {
  int id;
  String sellinno;
  String userid;
  String customerno;
  String sellindate;
  int regionid;
  int salesofficeid;
  int salesgroupid;
  int salesdistrictid;
  int cycle;
  int week;
  int year;
  bool needSync;
  bool isDelete;
  bool isLocal;


  Sellin(
      {this.id,
      this.sellinno,
      this.userid,
      this.customerno,
      this.sellindate,
      this.regionid,
      this.salesofficeid,
      this.salesgroupid,
      this.salesdistrictid,
      this.cycle,
      this.week,
      this.year,
      this.needSync,
      this.isDelete,
      this.isLocal,});

  Sellin.fromJson(Map<String, dynamic> map)
      : this.id = map["id"].toString().toInt(),
        this.sellinno = map["sellinno"].toString().clean(),
        this.userid = map["userid"].toString().clean(),
        this.customerno = map["customerno"].toString().clean(),
        this.sellindate = map["sellindate"].toString().clean(),
        this.regionid = map["regionid"].toString().toInt(),
        this.salesofficeid = map["salesofficeid"].toString().toInt(),
        this.salesgroupid = map["salesgroupid"].toString().toInt(),
        this.salesdistrictid = map["salesdistrictid"].toString().toInt(),
        this.cycle = map["cycle"].toString().toInt(),
        this.week = map["week"].toString().toInt(),
        this.year = map["year"].toString().toInt(),
        this.needSync = map["needSync"].toString().toBool(),
        this.isDelete = map["isDelete"].toString().toBool(),
        this.isLocal = map["isLocal"].toString().toBool();

  Sellin.createFromJson(Map<String, dynamic> map)
      : this.id = null,
        this.userid = session.userId(),
        this.sellinno = map["sellinno"].toString().clean(),
        this.customerno = map["customerno"].toString().clean(),
        this.sellindate = map["tanggalkunjungan"].toString().clean(),
        this.regionid = map["regionid"].toString().toInt(),
        this.salesofficeid = map["salesofficeid"].toString().toInt(),
        this.salesgroupid = map["salesgroupid"].toString().toInt(),
        this.salesdistrictid = map["salesdistrictid"].toString().toInt(),
        this.cycle = map["cycle"].toString().toInt(),
        this.week = map["week"].toString().toInt(),
        this.year = map["year"].toString().toInt(),
        this.needSync = true,
        this.isDelete = false,
        this.isLocal = true;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sellinno'] = this.sellinno;
    data['userid'] = this.userid;
    data['customerno'] = this.customerno;
    data['sellindate'] = this.sellindate;
    data['regionid'] = this.regionid;
    data['salesofficeid'] = this.salesofficeid;
    data['salesgroupid'] = this.salesgroupid;
    data['salesdistrictid'] = this.salesdistrictid;
    data['cycle'] = this.cycle;
    data['week'] = this.week;
    data['year'] = this.year;
    data['needSync'] = this.needSync;
    data['isDelete'] = this.isDelete;
    data['isLocal'] = this.isLocal;
    return data;
  }
}
