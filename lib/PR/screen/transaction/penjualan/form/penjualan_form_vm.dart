import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/helper/extension.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class PenjualanFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  SellinDetail sellinDetail = SellinDetail();
  List<MaterialPrice> listProduct = [];
  Sellin sellin;
  var autovalidateMode = AutovalidateMode.disabled;
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var price = TextEditingController();
  var introdeal = TextEditingController();
  var pac = TextEditingController();
  var slof = TextEditingController();
  var bal = TextEditingController();
  bool edit = false;
  String priceid;
  // Dao
  var _sellinDao = SellinDao();
  var _materialPriceDao = MaterialPriceDao();
  var _sellinDetailDao = SellinDetailDao();
  BuildContext _context;

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
    product.text = sellinDetail.materialname;
    pac.text = sellinDetail.pac.toString();
    slof.text = sellinDetail.slof.toString();
    bal.text = sellinDetail.bal.toString();
    price.text = sellinDetail.price.toString();
    introdeal.text = sellinDetail.qtyintrodeal.toString();
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

    var material =
    await _materialPriceDao.getByMaterialId(int.parse(materialid));

    var bal = (this.sellinDetail.bal ?? 0) * material.slof * material.pac;
    var slof = (this.sellinDetail.slof ?? 0) * material.pac;
    var pac = (this.sellinDetail.pac ?? 0);

    var price = material.price;
    var qty = bal + slof + pac;
    this.sellinDetail.price = price;
    this.sellinDetail.qty = qty;
    this.sellinDetail.sellinvalue = qty * price;

    if (edit) {
      this.sellinDetail.needSync = true;
      await _sellinDetailDao.update(this.sellinDetail);
    } else {
      this.sellinDetail.needSync = true;
      this.sellinDetail.isLocal = true;
      await _sellinDetailDao.insert(this.sellinDetail);
    }
    await _sellinDao.setNeedSync(sellinDetail.sellinid);
    Navigator.of(_context).pop("refresh");
  }

  materialPick(MaterialPrice data){
    this.sellinDetail.materialid = data.materialid;
    this.sellinDetail.materialname = data.materialname;
    notifyListeners();

    this.product.text = data.materialname;
    this.price.text = data.price.toString().toMoney();
  }
}
