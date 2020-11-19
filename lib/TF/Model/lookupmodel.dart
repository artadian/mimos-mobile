class LookupModel {
  String lookupid;
  String lookupkey;
  String lookupvalue;
  String lookupdesc;

  LookupModel(
      {this.lookupid, this.lookupkey, this.lookupvalue, this.lookupdesc});
  factory LookupModel.cretaeLookupFromJson(Map<String, dynamic> parsedJson) {
    return LookupModel(
      lookupid: parsedJson["lookupid"].toString(),
      lookupkey: parsedJson["lookupkey"].toString(),
      lookupvalue: parsedJson["lookupvalue"].toString(),
      lookupdesc: parsedJson["lookupdesc"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "lookupid": this.lookupid,
        "lookupkey": this.lookupkey,
        "lookupvalue": this.lookupvalue,
        "lookupdesc": this.lookupdesc,
      };
}
