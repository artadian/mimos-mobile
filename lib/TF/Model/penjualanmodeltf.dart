class PenjualanModelTF{
  String penjualantrxid;
  String customerno;
  String tglkunjungan;
  String userid;
  String materialid;
  String materialname;
  String pac;
  String slof;
  String bal;
  String introdeal;
  String harga;
  String rownumber;
  String nonota;
  String amountnota;
  String name;
  String address;
  String wspclass;
  PenjualanModelTF(
      {this.penjualantrxid,
      this.customerno,
      this.tglkunjungan,
      this.userid,
      this.materialid,
      this.materialname,
      this.pac,
      this.slof,
      this.bal,
      this.introdeal,
      this.harga,
      this.rownumber,
      this.nonota,
      this.amountnota,
      this.name,
      this.address,this.wspclass});
       factory PenjualanModelTF.createPenjualanFromJson(Map<String, dynamic> parsedJson) {
    return PenjualanModelTF(
      penjualantrxid: parsedJson["penjualantrxid"].toString(),
      customerno: parsedJson["customerno"].toString(),
      tglkunjungan: parsedJson["tglkunjungan"].toString(),
      userid: parsedJson["userid"].toString(),
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      pac: parsedJson["pac"].toString(),
      slof: parsedJson["slof"].toString(),
      bal: parsedJson["bal"].toString(),
      introdeal: parsedJson["introdeal"].toString(),
      harga: parsedJson["harga"].toString(),
      rownumber: parsedJson["rownumber"].toString(),
      nonota: parsedJson["nonota"].toString(),
      amountnota: parsedJson["amountnota"].toString(),
      name: parsedJson["name"].toString(),
      address: parsedJson["address"].toString(),
      wspclass: parsedJson["wspclass"].toString()
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
        "introdeal": this.introdeal,
        "harga": this.harga,
      };
}