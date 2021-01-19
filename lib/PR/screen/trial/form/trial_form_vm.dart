import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/brand_competitor_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/model/brand_competitor.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/helper/extension.dart';

class TrialFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var location = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var age = TextEditingController();
  var type = TextEditingController();
  var qty = TextEditingController();
  var price = TextEditingController();
  var amount = TextEditingController();
  var brandBefore = TextEditingController();
  var knowProduct = TextEditingController();
  var taste = TextEditingController();
  var packaging = TextEditingController();
  var outletName = TextEditingController();
  var outletAddress = TextEditingController();
  var notes = TextEditingController();
  // Dao
  var model = Trial();
  var _lookupDao = LookupDao();
  var _materialPriceDao = MaterialPriceDao();
  var _brandCompetitorDao = BrandCompetitorDao();
  List<MaterialPrice> listProduct = [];
  List<BrandCompetitor> listBrandCompetitor = [];
  bool edit = false;
  bool typeSwitching = false;

  init() async {
    await loadProducts();
    await loadBrandCompetitor();
    notifyListeners();
  }

  loadProducts() async {
    var res = await _materialPriceDao.getByPriceIdCust("Z5");
    listProduct = res;
    notifyListeners();
  }

  loadBrandCompetitor() async {
    var res = await _brandCompetitorDao.getAll();
    listBrandCompetitor = res;
    notifyListeners();
  }

  Future<List<Lookup>> getType() async {
    return await _lookupDao.getTrialType();
  }

  Future<List<Lookup>> getKnowing() async {
    return await _lookupDao.getKnowing();
  }

  Future<List<Lookup>> getTaste() async {
    return await _lookupDao.getTaste();
  }

  Future<List<Lookup>> getPackaging() async {
    return await _lookupDao.getPackaging();
  }

  onChangeQty(String val) async {
    var total = price.text.clearMoney().toInt(defaultVal: 0) * val.toInt(defaultVal: 0);
    amount.text = total.toString().toMoney();
  }

  onChangeType(String val){
    model.trialtype = val;
    if(val.toLowerCase() == "switching"){
      typeSwitching = true;
    }else{
      typeSwitching = false;
    }
    notifyListeners();
  }

  materialPick(MaterialPrice data) {
    this.model.materialid = data.materialid;
    this.model.materialname = data.materialname;
    notifyListeners();

    this.product.text = data.materialname;
    this.price.text = data.price.toString().toMoney();
  }

  brandPick(BrandCompetitor data) {
    this.model.competitorbrandid = data.id;
    this.model.competitorbrandname = data.competitorbrandname;
    notifyListeners();

    this.brandBefore.text = data.competitorbrandname;
  }


}
