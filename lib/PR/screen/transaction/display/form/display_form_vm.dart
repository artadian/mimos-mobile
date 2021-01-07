import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class DisplayFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  VisibilityDetail visibilityDetail = VisibilityDetail();
  List<MaterialPrice> listProduct = [];
  VisibilityModel visibilityModel;
  var autovalidateMode = AutovalidateMode.disabled;
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var pac = TextEditingController();
  bool edit = false;
  // Dao
  var _visibilityDao = VisibilityDao();
  var _materialPriceDao = MaterialPriceDao();
  var _visibilityDetailDao = VisibilityDetailDao();
  BuildContext _context;

  init(BuildContext context, VisibilityModel visibility, int id, String priceid) async {
    this._context = context;
    this.visibilityModel = visibility;
    if (id != null) {
      this.edit = true;
      await loadStockDetailForm(id);
    }
    loadProducts();
    notifyListeners();
  }

  loadStockDetailForm(int id) async {
    var res = await _visibilityDetailDao.getById(id);
    visibilityDetail = res;
    print(res.toJson());
    setForm();
  }

  loadProducts() async {
    var res = await _materialPriceDao.getAllMaterialOnly();
    listProduct = res;
    notifyListeners();
  }

  setForm() {
    product.text = visibilityDetail.materialname;
    pac.text = visibilityDetail.pac.toString();
  }

  save() async {
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      print("$runtimeType save: ${visibilityModel.id}");
      if (visibilityModel.id != null) {
        this.visibilityDetail.visibilityid = this.visibilityModel.id;
        saveDetail();
      } else {
        var id = await _visibilityDao.insert(visibilityModel);

        this.visibilityDetail.visibilityid = id;
        saveDetail();
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  saveDetail() async {
    var materialid = this.visibilityDetail.materialid;
    if (!edit) {
      var cekdata = await _visibilityDetailDao.getByParentAndMaterial(
          visibilityid: visibilityModel.id, materialid: materialid);
      if (cekdata.isNotEmpty) {
        MyToast.showToast("Material Sudah diinputkan",
            backgroundColor: Colors.red);
        return;
      }
    }

    if (edit) {
      this.visibilityDetail.needSync = true;
      await _visibilityDetailDao.update(this.visibilityDetail);
    } else {
      this.visibilityDetail.needSync = true;
      this.visibilityDetail.isLocal = true;
      await _visibilityDetailDao.insert(this.visibilityDetail);
    }
    Navigator.of(_context).pop("refresh");
  }

  materialPick(MaterialPrice data) {
    this.visibilityDetail.materialid = data.materialid;
    this.visibilityDetail.materialname = data.materialname;
    notifyListeners();

    this.product.text = data.materialname;
  }
}
