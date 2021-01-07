import 'package:mimos/helper/extension.dart';
import 'package:mimos/helper/session_manager.dart';

class Posm {
  int id;
  String userid;
  String customerno;
  String posmdate;
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

  Posm({
    this.id,
    this.userid,
    this.customerno,
    this.posmdate,
    this.regionid,
    this.salesofficeid,
    this.salesgroupid,
    this.salesdistrictid,
    this.cycle,
    this.week,
    this.year,
    this.needSync,
    this.isDelete,
    this.isLocal,
  });

  Posm.fromJson(Map<String, dynamic> map)
      : this.id = map["id"].toString().toInt(),
        this.userid = map["userid"].toString().clean(),
        this.customerno = map["customerno"].toString().clean(),
        this.posmdate = map["posmdate"].toString().clean(),
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

  Posm.createFromJson(Map<String, dynamic> map)
      : this.id = null,
        this.userid = session.userId(),
        this.customerno = map["customerno"].toString().clean(),
        this.posmdate = map["tanggalkunjungan"].toString().clean(),
        this.regionid = map["regionid"].toString().toNol(),
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
    data['userid'] = this.userid;
    data['customerno'] = this.customerno;
    data['posmdate'] = this.posmdate;
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
