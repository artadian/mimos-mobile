class MaterialModelTF {
  String materialid;
  String materialname;
  String materialgroupid;
  String bal;
  String slof;
  String pac;
  String materialgroupdescription;
  MaterialModelTF(
      {this.materialid,
      this.materialname,
      this.materialgroupid,
      this.bal,
      this.slof,
      this.pac,
      this.materialgroupdescription});
  factory MaterialModelTF.cretaeMaterialFromJson(
      Map<String, dynamic> parsedJson) {
    return MaterialModelTF(
      materialid: parsedJson["materialid"].toString(),
      materialname: parsedJson["materialname"].toString(),
      materialgroupid: parsedJson["materialgroupid"].toString(),
      bal: parsedJson["bal"].toString(),
      slof: parsedJson["slof"].toString(),
      pac: parsedJson["pac"].toString(),
      materialgroupdescription:
          parsedJson["materialgroupdescription"].toString(),
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "materialid": this.materialid,
        "materialname": this.materialname,
        "materialgroupid": this.materialgroupid,
        "bal": this.bal,
        "slof": this.slof,
        "pac": this.pac,
        "materialgroupdescription": this.materialgroupdescription
      };
}
