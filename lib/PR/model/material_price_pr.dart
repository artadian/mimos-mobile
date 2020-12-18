class MaterialPricePR {
  String materialid;
  String materialname;
  String priceid;
  String harga;
  String tglmulaiberlaku;

  MaterialPricePR({
    this.materialid,
    this.materialname,
    this.priceid,
    this.harga,
    this.tglmulaiberlaku,
  });

  factory MaterialPricePR.fromJson(Map<String, dynamic> parsedJson) {
    return MaterialPricePR(
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      priceid: parsedJson["priceid"].toString(),
      harga: parsedJson["harga"].toString(),
      tglmulaiberlaku: parsedJson["tglmulaiberlaku"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "materialid": this.materialid,
        "materialname": this.materialname,
        "priceid": this.priceid,
        "harga": this.harga,
        "tglmulaiberlaku": this.tglmulaiberlaku
      };
}
