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
  List<Map<String, dynamic>> listType = [];
  List<Map<String, dynamic>> listKnowing = [];
  List<Map<String, dynamic>> listTaste = [];
  List<Map<String, dynamic>> listPackaging = [];
  var autovalidateMode = AutovalidateMode.disabled;

  init() async {
    await loadProducts();
    await loadBrandCompetitor();
    await getType();
    await getKnowing();
    await getTaste();
    await getPackaging();
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

  getType() async {
    var res = await _lookupDao.getTrialType();
    listType = res.map((e) => e.toJson()).toList();
    notifyListeners();
  }

  getKnowing() async {
    var res = await _lookupDao.getKnowing();
    listKnowing = res.map((e) => e.toJson()).toList();
    notifyListeners();
  }

  getTaste() async {
    var res = await _lookupDao.getTaste();
    listTaste = res.map((e) => e.toJson()).toList();
    notifyListeners();
  }

  getPackaging() async {
    var res = await _lookupDao.getPackaging();
    listPackaging = res.map((e) => e.toJson()).toList();
    notifyListeners();
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

  setForm() {
    product.text = model.materialname;
    location.text = model.location;
    name.text = model.name;
    phone.text = model.phone;
    age.text = model.age.toString();
    type.text = model.trialtype;
    qty.text = model.qty.toString();
    price.text = model.price.toString().toMoney();
    amount.text = model.amount.toString().toMoney();
    brandBefore.text = model.competitorbrandname;
    knowProduct.text = model.knowing;
    taste.text = model.taste;
    packaging.text = model.packaging;
    outletName.text = model.outletname;
    outletAddress.text = model.outletaddress;
    notes.text = model.notes;
  }

  save() async {
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      print("$runtimeType save: ${model.toJson()}");
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
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
