class Lookup {
  String lookupid;
  String lookupvalue;
  String lookupdesc;
  String lookupkey;

  Lookup({
    this.lookupid,
    this.lookupvalue,
    this.lookupdesc,
    this.lookupkey,
  });

  Lookup.fromJson(Map<String, dynamic> json) {
    lookupid = json['lookupid'].toString();
    lookupvalue = json['lookupvalue'].toString();
    lookupdesc = json['lookupdesc'].toString();
    lookupkey = json['lookupkey'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookupid'] = this.lookupid;
    data['lookupvalue'] = this.lookupvalue;
    data['lookupdesc'] = this.lookupdesc;
    data['lookupkey'] = this.lookupkey;
    return data;
  }
}
