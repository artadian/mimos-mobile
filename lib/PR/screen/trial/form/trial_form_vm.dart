import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/dao/brand_competitor_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/trial_dao.dart';
import 'package:mimos/PR/model/brand_competitor.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class TrialFormVM with ChangeNotifier {
  DateTime now = DateTime.now();
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
  var _trialDao = TrialDao();
  List<MaterialPrice> listProduct = [];
  List<BrandCompetitor> listBrandCompetitor = [];
  bool edit = false;
  bool typeSwitching = false;
  List<Map<String, dynamic>> listType = [];
  List<Map<String, dynamic>> listKnowing = [];
  List<Map<String, dynamic>> listTaste = [];
  List<Map<String, dynamic>> listPackaging = [];
  var autovalidateMode = AutovalidateMode.disabled;
  BuildContext _context;
  var loading = true;

  init(BuildContext context, int id) async {
    this._context = context;
    await loadProducts();
    await loadBrandCompetitor();
    await getType();
    await getKnowing();
    await getTaste();
    await getPackaging();
    await loadData(id);
    notifyListeners();
  }

  loadData(int id) async {
    if (id != null) {
      edit = true;
      var res = await _trialDao.getById(id);
      model = res;
//      getMaterialPrice(res.materialid);
      setForm();
    }
    loading = false;
    notifyListeners();
  }

//  getMaterialPrice(String materialid) async {
//    var res = await _materialPriceDao.getByMaterialId(materialid);
//    this.price.text = res.price.toString().toMoney();
//    getAmount();
//  }

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

  getAmount() async {
    var total = price.text.clearMoney().toDouble(defaultVal: 0.0) *
        qty.text.toInt(defaultVal: 0);
    amount.text = total.toString().toMoney();
  }

  onChangeType(String val) {
    model.trialtype = val;
    var list = listType.map((e) => Lookup.fromJson(e)).toList();
    var data = list.firstWhere((e) => e.lookupvalue == val);
    if (data.lookupdesc.toLowerCase() == "switching") {
      typeSwitching = true;
      qty.text = "1";
      price.text = "0";
      amount.text = "0";
    } else {
      model.materialid = null;
      model.materialname = null;
      product.text = "";
//      qty.text = model.qty.toString().clean() ?? "";
//      price.text = model.price.toString().toMoney() ?? "";
//      amount.text = model.amount.toString().toMoney() ?? "";
      typeSwitching = false;
    }
    notifyListeners();
  }

  onChangeTaste(String val) {
    model.taste = val;
    notifyListeners();
  }

  onChangeKnowing(String val) {
    model.knowing = val;
    notifyListeners();
  }

  onChangePackaging(String val) {
    model.packaging = val;
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
    var date = DateFormat("yyyy-MM-dd").format(now);
    print("$runtimeType save: ${model.toJson()}");
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      model.userid = await session.getUserId();
      model.trialdate = date;
      if (edit) {
        model.needSync = true;
        await _trialDao.update(model);
      } else {
        model.needSync = true;
        model.isLocal = true;
        await _trialDao.insert(model);
      }
      MyToast.showToast("Berhasil menyimpan data",
          backgroundColor: Colors.green);
      Navigator.of(_context).pop("refresh");
    } else {
      MyToast.showToast("Gagal, Lengkapi semua data",
          backgroundColor: Colors.red);
      autovalidateMode = AutovalidateMode.always;
    }

  }

  materialPick(MaterialPrice data) {
    this.model.materialid = data.materialid;
    this.model.materialname = data.materialname;
    notifyListeners();

    this.product.text = data.materialname;
    if(!typeSwitching){
      if(model.qty == null || model.qty == 0) {
        this.qty.text = "1";
      }
      this.price.text = data.price.toString().toMoney();
      getAmount();
    }
  }

  brandPick(BrandCompetitor data) {
    this.model.competitorbrandid = data.id;
    this.model.competitorbrandname = data.competitorbrandname;
    notifyListeners();

    this.brandBefore.text = data.competitorbrandname;
  }
}
