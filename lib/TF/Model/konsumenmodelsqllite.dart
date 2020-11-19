class KonsumenModelSQLite {
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
  String tanggalkunjungan;
  String notvisitreason ;
  String notbuyreason;
  String lookupdescvisitreason;
  String lookupdescbuyreason;
  String nonota;
  String amountnota;
  String visittrxid;
  String wspclass;
  KonsumenModelSQLite(
      {this.id,
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
      this.tanggalkunjungan,
      this.notvisitreason,
      this.notbuyreason,
      this.lookupdescvisitreason,
      this.lookupdescbuyreason,
      this.nonota,
      this.amountnota,this.visittrxid,this.wspclass});
  factory KonsumenModelSQLite.createCustomerFromJson(
      Map<String, dynamic> _map) {
    return KonsumenModelSQLite(
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
      tanggalkunjungan: _map["tanggalkunjungan"].toString(),
      notvisitreason :_map["notvisitreason"].toString(),
      notbuyreason: _map["notbuyreason"].toString(),
      lookupdescvisitreason: _map["lookupdescvisitreason"].toString(),
      lookupdescbuyreason: _map["lookupdescbuyreason"].toString(),
      nonota: _map["nonota"].toString(),
      amountnota: _map["amountnota"].toString(),
      visittrxid :_map["visittrxid"].toString(),
      wspclass :_map["wspclass"].toString(),
    );
  }
   Map<String, dynamic> toDatabaseJson() {
     return{
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
        "tanggalkunjungan": this.tanggalkunjungan,
     };
      }
}