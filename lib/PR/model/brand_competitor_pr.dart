class BrandCompetitorPR {
  String sobid;
  String soid;
  String materialgroup;
  String competitorbrand;

  BrandCompetitorPR({
    this.sobid,
    this.soid,
    this.materialgroup,
    this.competitorbrand,
  });

  BrandCompetitorPR.fromJson(Map<String, dynamic> json) {
    sobid = json['sobid'].toString();
    soid = json['soid'].toString();
    materialgroup = json['materialgroup'].toString();
    competitorbrand = json['competitorbrand'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sobid'] = this.sobid;
//    data['soid'] = this.soid;
//    data['materialgroup'] = this.materialgroup;
    data['salesofficeid'] = this.soid;
    data['materialgroupid'] = this.materialgroup;
    data['competitorbrand'] = this.competitorbrand;
    return data;
  }
}
