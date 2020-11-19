class LookupModelFL {
  String lookupid;
  String lookupvalue;
  String lookupdesc;
  String lookupkey;

  LookupModelFL(
      {this.lookupid, this.lookupvalue, this.lookupdesc, this.lookupkey});

  LookupModelFL.fromJson(Map<String, dynamic> json) {
    lookupid = json['lookupid'];
    lookupvalue = json['lookupvalue'];
    lookupdesc = json['lookupdesc'];
    lookupkey = json['lookupkey'];
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
