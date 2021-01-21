import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/dao/customer_introdeal_dao.dart';
import 'package:mimos/PR/dao/introdeal_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/model/customer_introdeal.dart';
import 'package:mimos/PR/model/introdeal.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class PenjualanFormVM with ChangeNotifier {
  DateTime now = DateTime.now();
  var saving; // null: default, -1: error, 0: loading, 1: success
  SellinDetail sellinDetail = SellinDetail();
  List<MaterialPrice> listProduct = [];
  Sellin sellin;
  var autovalidateMode = AutovalidateMode.disabled;
  // Form
  final keyForm = GlobalKey<FormState>();
  var etProduct = TextEditingController();
  var etPrice = TextEditingController();
  var etIntrodeal = TextEditingController();
  var etPac = TextEditingController();
  var etSlof = TextEditingController();
  var etBal = TextEditingController();
  bool edit = false;
  String priceid;
  // Dao
  var _sellinDao = SellinDao();
  var _materialPriceDao = MaterialPriceDao();
  var _sellinDetailDao = SellinDetailDao();
  var _introdealDao = IntrodealDao();
  var _custIntrodealDao = CustomerIntrodealDao();
  BuildContext _context;
  var qty = 0;
  Introdeal introdeal;
  MaterialPrice materialPrice;

  init(BuildContext context, Sellin sellin, int id, String priceid) async {
    this.sellin = sellin;
    this.priceid = priceid;
    this._context = context;
    if (id != null) {
      this.edit = true;
      await loadSellinDetailForm(id);
    }
    loadProducts();
    notifyListeners();
  }

  loadSellinDetailForm(int id) async {
    var res = await _sellinDetailDao.getById(id);
    sellinDetail = res;
    getIntrodeal(materialid: res.materialid);
    materialPrice = await _materialPriceDao.getByMaterialId(res.materialid);
    notifyListeners();
    setForm();
  }

  loadProducts() async {
    var res = await _materialPriceDao.getByPriceIdCust(priceid);
    listProduct = res;
    res.forEach((e) {
      print("$runtimeType listProduct: ${e.toJson()}");
    });
    notifyListeners();
  }

  setForm() {
    etProduct.text = sellinDetail.materialname;
    etPac.text = sellinDetail.pac.toString();
    etSlof.text = sellinDetail.slof.toString();
    etBal.text = sellinDetail.bal.toString();
    etPrice.text = sellinDetail.price.toString();
    etIntrodeal.text = sellinDetail.qtyintrodeal.toString();
  }

  save() async {
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      print("$runtimeType save: ${sellin.id}");
      if (sellin.id != null) {
        this.sellinDetail.sellinid = this.sellin.id;
        saveDetail();
      } else {
        var id = await _sellinDao.insert(sellin);

        this.sellinDetail.sellinid = id;
        saveDetail();
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  getIntrodeal({String materialid}) async {
    var introdeal;
    if (edit) {
      introdeal = await _introdealDao.getBySellinDetail(sellinDetail.id);
    } else {
      introdeal = await _introdealDao.getByMaterial(
        materialid,
        customerno: sellin.customerno,
      );
    }

    if (introdeal == null) {
      etIntrodeal.text = "0";
      return;
    }

    this.introdeal = introdeal;
    notifyListeners();
    setBonusIntrodeal();
  }

  onChangeQty(String val, {String tag}) async {
    this.qty = 0;
    if (introdeal == null) {
      etIntrodeal.text = "0";
      return;
    }
    setBonusIntrodeal();
  }

  setBonusIntrodeal() {
    int bal = this.etBal.text.toInt(defaultVal: 0) *
        materialPrice.slof.cekNull() *
        materialPrice.pac.cekNull();
    int slof =
        this.etSlof.text.toInt(defaultVal: 0) * materialPrice.pac.cekNull();
    int pac = this.etPac.text.toInt(defaultVal: 0);
    this.qty = bal + slof + pac;

    if (qty < this.introdeal.qtyorder) {
      etIntrodeal.text = "0";
      return;
    }

    var bonus = (qty ~/ this.introdeal.qtyorder) * this.introdeal.qtybonus;
    etIntrodeal.text = bonus.round().toString();
    notifyListeners();
  }

  saveDetail() async {
    var materialid = this.sellinDetail.materialid;
    if (!edit) {
      var cekdata = await _sellinDetailDao.getByParentAndMaterial(
          sellinid: sellin.id, materialid: materialid);
      if (cekdata.isNotEmpty) {
        MyToast.showToast("Material Sudah diinputkan",
            backgroundColor: Colors.red);
        return;
      }
    }

    var material = await _materialPriceDao.getByMaterialId(materialid);

    var bal = (this.sellinDetail.bal ?? 0) * material.slof * material.pac;
    var slof = (this.sellinDetail.slof ?? 0) * material.pac;
    var pac = (this.sellinDetail.pac ?? 0);

    var price = material.price;
    var qty = bal + slof + pac;
    this.sellinDetail.price = price;
    this.sellinDetail.qty = qty;
    this.sellinDetail.sellinvalue = qty * price;
    this.sellinDetail.qtyintrodeal = etIntrodeal.text.toInt(defaultVal: 0);

    if (qty <= 0) {
      MyToast.showToast("Masukkan jumlah pesanan (PAC/SLOF/BAL)",
          backgroundColor: Colors.red);
      return;
    }

    if (edit) {
      // save sellin detail
      this.sellinDetail.needSync = true;
      await _sellinDetailDao.update(this.sellinDetail);
    } else {
      // save sellin detail
      this.sellinDetail.needSync = true;
      this.sellinDetail.isLocal = true;
      var idSellinDetail = await _sellinDetailDao.insert(this.sellinDetail);

      // save customer introdeal
      if (introdeal != null) {
        var custIntrodeal = CustomerIntrodeal.create(
            customerno: sellin.customerno,
            introdealid: introdeal.id,
            sellindetailid: idSellinDetail,
            materialid: materialPrice.materialid);
        _custIntrodealDao.insert(custIntrodeal);
      }
    }

    await _sellinDao.setNeedSync(sellinDetail.sellinid);
    Navigator.of(_context).pop("refresh");
  }

  materialPick(MaterialPrice data) {
    this.sellinDetail.materialid = data.materialid;
    this.sellinDetail.materialname = data.materialname;
    this.materialPrice = data;
    getIntrodeal(materialid: data.materialid);
    notifyListeners();

    this.etProduct.text = data.materialname;
    this.etPrice.text = data.price.toString().toMoney();
  }
}
