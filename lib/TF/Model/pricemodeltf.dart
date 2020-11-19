class PriceModelTF {
  String materialid;
  String materialname;
  String priceid;
  String harga;
  String tglmulaiberlaku;

  PriceModelTF(
      {this.materialid,
      this.materialname,
      this.priceid,
      this.harga,
      this.tglmulaiberlaku});
  factory PriceModelTF.cretaePriceTFFromJson(Map<String, dynamic> parsedJson) {
    return PriceModelTF(
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      priceid: parsedJson["priceid"].toString(),
      harga: parsedJson["harga"].toString(),
      tglmulaiberlaku: parsedJson["tglmulaiberlaku"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "materialid": this.materialid,
        "materialname": this.materialname,
        "priceid": this.priceid,
        "harga": this.harga,
        "tglmulaiberlaku": this.tglmulaiberlaku
      };
}
