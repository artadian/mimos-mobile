class BrandCompetitorModelFL {
  String sobid;
  String soid;
  String materialgroup;
  String competitorbrand;

  BrandCompetitorModelFL(
      {this.sobid, this.soid, this.materialgroup, this.competitorbrand});

  BrandCompetitorModelFL.fromJson(Map<String, dynamic> json) {
    sobid = json['sobid'].toString();
    soid = json['soid'].toString();
    materialgroup = json['materialgroup'].toString();
    competitorbrand = json['competitorbrand'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sobid'] = this.sobid;
    data['soid'] = this.soid;
    data['materialgroup'] = this.materialgroup;
    data['competitorbrand'] = this.competitorbrand;
    return data;
  }
}
