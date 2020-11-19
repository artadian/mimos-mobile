class IntrodealModelTF {
  String materialid;
  String materialname;
  String qtyorder;
  String qtybonus;
  String tglmulaiberlaku;
  String tglakhirberlaku;
  String since;
String expired;
  IntrodealModelTF(
      {this.materialid,
      this.materialname,
      this.qtyorder,
      this.qtybonus,
      this.tglmulaiberlaku,
      this.tglakhirberlaku,
      this.since,
      this.expired});
  factory IntrodealModelTF.cretaeIntrodealTFFromJson(Map<String, dynamic> parsedJson) {
    return IntrodealModelTF(
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      qtyorder: parsedJson["qtyorder"].toString(),
      qtybonus: parsedJson["qtybonus"].toString(),
      tglmulaiberlaku: parsedJson["tglmulaiberlaku"].toString(),
      tglakhirberlaku: parsedJson["tglakhirberlaku"].toString(),
      since: parsedJson["since"].toString(),
      expired: parsedJson["expired"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "materialid": this.materialid,
        "materialname": this.materialname,
        "qtyorder": this.qtyorder,
        "qtybonus": this.qtybonus,
        "tglmulaiberlaku": this.tglmulaiberlaku
      };
}
