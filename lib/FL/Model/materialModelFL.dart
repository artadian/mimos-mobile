class MaterialModelFL {
  String materialid;
  String materialname;
  String materialgroupid;
  String materialgroupdescription;
  String priceid;
  String price;

  MaterialModelFL(
      {this.materialid,
      this.materialname,
      this.materialgroupid,
      this.materialgroupdescription,
      this.priceid,
      this.price});

  MaterialModelFL.fromJson(Map<String, dynamic> json) {
    materialid = json['materialid'].toString();
    materialname = json['materialname'].toString();
    materialgroupid = json['materialgroupid'].toString();
    materialgroupdescription = json['materialgroupdescription'].toString();
    priceid = json['priceid'].toString();
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['materialid'] = this.materialid;
    data['materialname'] = this.materialname;
    data['materialgroupid'] = this.materialgroupid;
    data['materialgroupdescription'] = this.materialgroupdescription;
    data['priceid'] = this.priceid;
    data['price'] = this.price;
    return data;
  }
}
