import 'package:mimos/helper/extension.dart';

class CustomerPR {
  int id;
  String customerno;
  String userid;
  String visitday;
  String visitweek;
  String name;
  String address;
  String city;
  String owner;
  String phone;
  String customergroupid;
  String customergroupname;
  String priceid;
  String salesdistrictid;
  String salesdistrictname;
  String salesgroupid;
  String salesgroupname;
  String salesofficeid;
  String salesofficename;
  String usersfaid;
  String userroleid;
  int regionid;
  String tanggalkunjungan;
  String notvisitreason;
  String notbuyreason;
  String lookupdescvisitreason;
  String lookupdescbuyreason;
  String nonota;
  String amountnota;
  int idvisit;
  String wspclass;
  String ycw;
  int year;
  int cycle;
  int week;
  int nourut;

  CustomerPR({
    this.id,
    this.customerno,
    this.userid,
    this.visitday,
    this.visitweek,
    this.name,
    this.address,
    this.city,
    this.owner,
    this.phone,
    this.customergroupid,
    this.customergroupname,
    this.priceid,
    this.salesdistrictid,
    this.salesdistrictname,
    this.salesgroupid,
    this.salesgroupname,
    this.salesofficeid,
    this.salesofficename,
    this.usersfaid,
    this.userroleid,
    this.regionid,
    this.tanggalkunjungan,
    this.notvisitreason,
    this.notbuyreason,
    this.lookupdescvisitreason,
    this.lookupdescbuyreason,
    this.nonota,
    this.amountnota,
    this.idvisit,
    this.wspclass,
    this.ycw,
    this.year,
    this.cycle,
    this.week,
    this.nourut,
  });

  factory CustomerPR.fromTable(Map<String, dynamic> _map) {
    return CustomerPR(
      id: _map["id"],
      customerno: _map["customerno"].toString(),
      userid: _map["userid"].toString(),
      visitday: _map["visitday"].toString(),
      visitweek: _map["visitweek"].toString(),
      name: _map["name"].toString(),
      address: _map["address"].toString(),
      city: _map["city"].toString(),
      owner: _map["owner"].toString(),
      phone: _map["phone"].toString(),
      customergroupid: _map["customergroupid"].toString(),
      customergroupname: _map["customergroupname"].toString(),
      priceid: _map["priceid"].toString(),
      salesdistrictid: _map["salesdistrictid"].toString(),
      salesdistrictname: _map["salesdistrictname"].toString(),
      salesgroupid: _map["salesgroupid"].toString(),
      salesgroupname: _map["salesgroupname"].toString(),
      salesofficeid: _map["salesofficeid"].toString(),
      salesofficename: _map["salesofficename"].toString(),
      usersfaid: _map["usersfaid"].toString(),
      userroleid: _map["userroleid"].toString(),
      regionid: _map["regionid"].toString().toInt(),
      tanggalkunjungan: _map["tanggalkunjungan"].toString(),
      notvisitreason: _map["notvisitreason"].toString(),
      notbuyreason: _map["notbuyreason"].toString(),
      lookupdescvisitreason: _map["lookupdescvisitreason"].toString(),
      lookupdescbuyreason: _map["lookupdescbuyreason"].toString(),
      nonota: _map["nonota"].toString(),
      amountnota: _map["amountnota"].toString(),
      idvisit: _map["idvisit"].toString().toInt(),
      wspclass: _map["wspclass"].toString(),
      year: _map["year"].toString().toInt(),
      cycle: _map["cycle"].toString().toInt(),
      week: _map["week"].toString().toInt(),
      nourut: _map["nourut"].toString().toInt(),
    );
  }

  factory CustomerPR.fromJson(Map<String, dynamic> _map) {
    print('customer: ${_map["ycw"]}');
    List<String> arr = _map["ycw"].toString().split(';');
    int _year = arr[0].toString().toInt();
    int _cycle = arr[1].toString().toInt();
    int _week = arr[2].toString().toInt();
    return CustomerPR(
      id: _map["id"],
      customerno: _map["customerno"].toString(),
      userid: _map["userid"].toString(),
      visitday: _map["visitday"].toString(),
      visitweek: _map["visitweek"].toString(),
      name: _map["name"].toString(),
      address: _map["address"].toString(),
      city: _map["city"].toString(),
      owner: _map["owner"].toString(),
      phone: _map["phone"].toString(),
      customergroupid: _map["customergroupid"].toString(),
      customergroupname: _map["customergroupname"].toString(),
      priceid: _map["priceid"].toString(),
      salesdistrictid: _map["salesdistrictid"].toString(),
      salesdistrictname: _map["salesdistrictname"].toString(),
      salesgroupid: _map["salesgroupid"].toString(),
      salesgroupname: _map["salesgroupname"].toString(),
      salesofficeid: _map["salesofficeid"].toString(),
      salesofficename: _map["salesofficename"].toString(),
      usersfaid: _map["usersfaid"].toString(),
      userroleid: _map["userroleid"].toString(),
      regionid: _map["regionid"].toString().toInt(),
      tanggalkunjungan: _map["tanggalkunjungan"].toString(),
      notvisitreason: _map["notvisitreason"].toString(),
      notbuyreason: _map["notbuyreason"].toString(),
      lookupdescvisitreason: _map["lookupdescvisitreason"].toString(),
      lookupdescbuyreason: _map["lookupdescbuyreason"].toString(),
      nonota: _map["nonota"].toString(),
      amountnota: _map["amountnota"].toString(),
      idvisit: _map["idvisit"].toString().toInt(),
      wspclass: _map["wspclass"].toString(),
      ycw: _map["ycw"].toString(),
      nourut: _map["nourut"].toString().toInt(),
      year: _year,
      cycle: _cycle,
      week: _week,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerno": this.customerno,
      "userid": this.userid,
      "visitday": this.visitday,
      "visitweek": this.visitweek,
      "name": this.name,
      "address": this.address,
      "city": this.city,
      "owner": this.owner,
      "phone": this.phone,
      "customergroupid": this.customergroupname,
      "customergroupname": this.customergroupname,
      "priceid": this.priceid,
      "salesdistrictid": this.salesdistrictid,
      "salesdistrictname": this.salesdistrictname,
      "salesgroupid": this.salesgroupid,
      "salesgroupname": this.salesgroupname,
      "salesofficeid": this.salesofficeid,
      "salesofficename": this.salesofficename,
      "usersfaid": this.usersfaid,
      "userroleid": this.userroleid,
      "regionid": this.regionid,
      "tanggalkunjungan": this.tanggalkunjungan,
      "wspclass": this.wspclass,
      "year": this.year,
      "cycle": this.cycle,
      "week": this.week,
      "nourut": this.nourut,
    };
  }

  Map<String, dynamic> toJsonView() {
    return {
      "id": this.id,
      "customerno": this.customerno,
      "userid": this.userid,
      "visitday": this.visitday,
      "visitweek": this.visitweek,
      "name": this.name,
      "address": this.address,
      "city": this.city,
      "owner": this.owner,
      "phone": this.phone,
      "customergroupid": this.customergroupid,
      "customergroupname": this.customergroupname,
      "priceid": this.priceid,
      "salesdistrictid": this.salesdistrictid,
      "salesdistrictname": this.salesdistrictname,
      "salesgroupid": this.salesgroupid,
      "salesgroupname": this.salesgroupname,
      "salesofficeid": this.salesofficeid,
      "salesofficename": this.salesofficename,
      "usersfaid": this.usersfaid,
      "userroleid": this.userroleid,
      "regionid": this.regionid,
      "tanggalkunjungan": this.tanggalkunjungan,
      "notvisitreason": this.notvisitreason,
      "notbuyreason": this.notbuyreason,
      "lookupdescvisitreason": this.lookupdescvisitreason,
      "lookupdescbuyreason": this.lookupdescbuyreason,
      "nonota": this.nonota,
      "amountnota": this.amountnota,
      "idvisit": this.idvisit,
      "wspclass": this.wspclass,
      "ycw": this.ycw,
      "year": this.year,
      "cycle": this.cycle,
      "week": this.week,
      "nourut": this.nourut,
    };
  }
}
