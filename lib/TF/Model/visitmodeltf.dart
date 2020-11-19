class VisitModelTF{
  String customerno;
  String tglkunjungan;
  String userid;
  String notvisitreason;
  
  VisitModelTF({this.customerno,this.tglkunjungan,this.userid,this.notvisitreason});
  factory VisitModelTF.createVisitTFFromJson(Map<String, dynamic> parsedJson) {
 return VisitModelTF(
      customerno: parsedJson["customerno"].toString(),
      tglkunjungan: parsedJson["tglkunjungan"].toString(),
      userid: parsedJson["userid"].toString(),
      notvisitreason: parsedJson["notvisitreason"].toString(),
    );
  }
   Map<String, dynamic> toDatabaseJson() => {
        "customerno": this.customerno,
        "tglkunjungan": this.tglkunjungan,
        "userid": this.userid,
        "notvisitreason": this.notvisitreason
      };
}