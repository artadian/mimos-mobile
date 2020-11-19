class StockModelTF {
  String stocktrxid;
  String customerno;
  String tglkunjungan;
  String userid;
  String materialid;
  String materialname;
  String pac;
  String slof;
  String bal;
  String ismaterialdefault;
  String iscek;
  StockModelTF(
      {this.stocktrxid,
      this.customerno,
      this.tglkunjungan,
      this.userid,
      this.materialid,
      this.materialname,
      this.pac,
      this.slof,
      this.bal,
      this.ismaterialdefault,
      this.iscek});
  factory StockModelTF.createStockFromJson(Map<String, dynamic> parsedJson) {
    return StockModelTF(
      stocktrxid: parsedJson["stocktrxid"].toString(),
      customerno: parsedJson["customerno"].toString(),
      tglkunjungan: parsedJson["tglkunjungan"].toString(),
      userid: parsedJson["userid"].toString(),
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      pac: parsedJson["pac"].toString(),
      slof: parsedJson["slof"].toString(),
      bal: parsedJson["bal"].toString(),
      ismaterialdefault: parsedJson["ismaterialdefault"].toString(),
      iscek: parsedJson["iscek"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "customerno": this.customerno,
        "userid": this.userid,
        "tglkunjungan": this.tglkunjungan,
        "materialid": this.materialid,
        "pac": this.pac,
        "slof": this.slof,
        "bal": this.bal,
         "ismaterialdefault": this.ismaterialdefault,
        "iscek": this.iscek,
      };
}
