import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/view/posm_detail_view.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class PosmFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  PosmDetailView posmDetail = PosmDetailView();
  List<MaterialPrice> listProduct = [];
  Posm posmModel;
  var autovalidateMode = AutovalidateMode.disabled;
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var qty = TextEditingController();
  var notes = TextEditingController();
  bool edit = false;
  // Dao
  var _posmDao = PosmDao();
  var _materialPriceDao = MaterialPriceDao();
  var _posmDetailDao = PosmDetailDao();
  var _lookupDao = LookupDao();
  BuildContext _context;

  init(BuildContext context, Posm posm, int id, String priceid) async {
    this._context = context;
    this.posmModel = posm;
    if (id != null) {
      this.edit = true;
      await loadStockDetailForm(id);
    }
    loadProducts();
    notifyListeners();
  }

  loadStockDetailForm(int id) async {
    var res = await _posmDetailDao.getByIdForm(id);
    posmDetail = res;
    print(res.toJson());
    setForm();
  }

  loadProducts() async {
    var res = await _materialPriceDao.getAllMaterialOnly();
    listProduct = res;
    notifyListeners();
  }

  Future<List<Lookup>> getType() async {
    return await _lookupDao.getPosmType();
  }

  Future<List<Lookup>> getStatus() async {
    return await _lookupDao.getStatus();
  }

  Future<List<Lookup>> getCondition() async {
    return await _lookupDao.getCondition();
  }

  changeStatus(String val) {
    posmDetail.status = val;
    notifyListeners();
  }

  changeCondition(String val) {
    posmDetail.status = val;
    notifyListeners();
  }

  setForm() {
    product.text = posmDetail.materialgroupdesc;
    qty.text = posmDetail.qty.toString();
    notes.text = posmDetail.notes;
  }

  save() async {
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      print("$runtimeType save: ${posmModel.id}");
      if (posmModel.id != null) {
        this.posmDetail.posmid = this.posmModel.id;
        saveDetail();
      } else {
        var id = await _posmDao.insert(posmModel);

        this.posmDetail.posmid = id;
        saveDetail();
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  saveDetail() async {
    var materialgroupid = this.posmDetail.materialgroupid;
    var type = this.posmDetail.posmtypeid;
//    var status = this.posmDetail.status;
    if (!edit) {
      var cekdata = await _posmDetailDao.getByParentAndMaterial(
          posmid: posmModel.id,
          materialgroupid: materialgroupid,
          type: type);
      if (cekdata.isNotEmpty) {
        MyToast.showToast("Material Sudah diinputkan",
            backgroundColor: Colors.red);
        return;
      }
    }

    if(posmDetail.status != "2"){
      posmDetail.condition = null;
      posmDetail.notes = null;
    }

    var model = PosmDetail.createFromJson(posmDetail.toJson());
    if (edit) {
      model.isLocal = false;
      await _posmDetailDao.update(model);
    } else {
      await _posmDetailDao.insert(model);
    }
    Navigator.of(_context).pop("refresh");
  }

  materialPick(MaterialPrice data) {
    this.posmDetail.materialgroupid = data.materialgroupid;
    this.posmDetail.materialgroupname = data.materialgroupname;
    this.posmDetail.materialgroupdesc = data.materialgroupdesc;
    notifyListeners();

    this.product.text = data.materialgroupdesc;
  }
}
