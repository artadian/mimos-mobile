import 'package:mimos/helper/extension.dart';
import 'package:mimos/helper/session_manager.dart';

class Visit {
  int id;
  String userid;
  String customerno;
  String visitdate;
  String notvisitreason;
  String notbuyreason;
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

  Visit({
    this.id,
    this.userid,
    this.customerno,
    this.visitdate,
    this.notvisitreason,
    this.notbuyreason,
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

  Visit.fromJson(Map<String, dynamic> map)
      : this.id = map["id"].toString().toInt(),
        this.userid = map["userid"].toString().clean(),
        this.customerno = map["customerno"].toString().clean(),
        this.visitdate = map["visitdate"].toString().clean(),
        this.notvisitreason = map["notvisitreason"].toString().clean(),
        this.notbuyreason = map["notbuyreason"].toString().clean(),
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

  Visit.createFromJson(Map<String, dynamic> map)
      : this.id = map["idvisit"].toString().toInt(),
        this.userid = session.userId(),
        this.customerno = map["customerno"].toString().clean(),
        this.visitdate = map["tanggalkunjungan"].toString().clean(),
        this.notvisitreason = map["notvisitreason"].toString().toNolStr(),
        this.notbuyreason = map["notbuyreason"].toString().toNolStr(),
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
    data['visitdate'] = this.visitdate;
    data['notvisitreason'] = this.notvisitreason;
    data['notbuyreason'] = this.notbuyreason;
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
