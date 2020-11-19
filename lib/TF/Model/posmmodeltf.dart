class POSMModelTF{
  String posmtrxid;
  String customerno;
  String tglkunjungan;
  String userid;
  String materialid;
  String materialname;
  String type;
  String typedescription;
  String qty;
  String status;
  String statusdescription;
  String condition;
  String conditiondescription;
  String note;
  String rownumber;
   POSMModelTF(
      {this.posmtrxid,
      this.customerno,
      this.tglkunjungan,
      this.userid,
      this.materialid,
      this.materialname,
      this.type,
      this.typedescription,
      this.qty,
      this.status,
      this.statusdescription,
       this.condition,
      this.conditiondescription,
      this.note,
      this.rownumber});
       factory POSMModelTF.createPOSMFromJson(Map<String, dynamic> parsedJson) {
    return POSMModelTF(
      posmtrxid: parsedJson["posmtrxid"].toString(),
      customerno: parsedJson["customerno"].toString(),
      tglkunjungan: parsedJson["tglkunjungan"].toString(),
      userid: parsedJson["userid"].toString(),
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      type: parsedJson["type"].toString(),
      typedescription: parsedJson["typedescription"].toString(),
      qty: parsedJson["qty"].toString(),
      status: parsedJson["status"].toString(),
      statusdescription: parsedJson["statusdescription"].toString(),
      condition: parsedJson["condition"].toString(),
      conditiondescription: parsedJson["conditiondescription"].toString(),
      note: parsedJson["note"].toString(),
      rownumber: parsedJson["rownumber"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "customerno": this.customerno,
        "userid": this.userid,
        "tglkunjungan": this.tglkunjungan,
        "materialid": this.materialid,
        "type": this.type,
        "qty": this.qty,
        "status": this.status,
        "note": this.note,
        "condition": this.condition,
      };
}