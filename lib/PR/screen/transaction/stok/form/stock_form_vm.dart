import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/model/material_price.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class StokFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  StockDetail stockDetail = StockDetail();
  List<MaterialPrice> listProduct = [];
  Stock stock;
  var autovalidateMode = AutovalidateMode.disabled;
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var pac = TextEditingController();
  var slof = TextEditingController();
  var bal = TextEditingController();
  String priceid;
  bool edit = false;
  // Dao
  var _stockDao = StockDao();
  var _materialPriceDao = MaterialPriceDao();
  var _stockDetailDao = StockDetailDao();
  BuildContext _context;

  init(BuildContext context, Stock stock, int id, String priceid) async {
    this._context = context;
    this.stock = stock;
    this.priceid = priceid;
    if (id != null) {
      this.edit = true;
      await loadStockDetailForm(id);
    }
    loadProducts();
    notifyListeners();
  }

  loadStockDetailForm(int id) async {
    var res = await _stockDetailDao.getById(id);
    stockDetail = res;
    print(res.toJson());
    setForm();
  }

  loadProducts() async {
    var res = await _materialPriceDao.getByPriceIdCust(priceid);
    listProduct = res;
//    res.forEach((e) {
//      print("$runtimeType listProduct: ${e.toJson()}");
//    });
    notifyListeners();
  }

  setForm() {
    product.text = stockDetail.materialname;
    pac.text = stockDetail.pac.toString();
    slof.text = stockDetail.slof.toString();
    bal.text = stockDetail.bal.toString();
  }

  save() async {
    if (keyForm.currentState.validate()) {
      autovalidateMode = AutovalidateMode.disabled;
      keyForm.currentState.save();
      print("$runtimeType save: ${stock.id}");
      if (stock.id != null) {
        this.stockDetail.stockid = this.stock.id;
        saveDetail();
      } else {
        var id = await _stockDao.insert(stock);

        this.stockDetail.stockid = id;
        saveDetail();
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  saveDetail() async {
    var materialid = this.stockDetail.materialid;
    var cekdata = await _stockDetailDao.getByParentAndMaterial(
        stockid: stock.id, materialid: materialid);
    if (cekdata.isNotEmpty) {
      MyToast.showToast("Material Sudah diinputkan",
          backgroundColor: Colors.red);
      return;
    }

    var material =
        await _materialPriceDao.getByMaterialId(int.parse(materialid));

    var bal = (this.stockDetail.bal ?? 0) * material.slof * material.pac;
    var slof = (this.stockDetail.slof ?? 0) * material.pac;
    var pac = (this.stockDetail.pac ?? 0);
    var qty = bal + slof + pac;
    this.stockDetail.qty = qty;

    if (edit) {
      this.stockDetail.needSync = true;
      await _stockDetailDao.update(this.stockDetail);
    } else {
      this.stockDetail.needSync = true;
      this.stockDetail.isLocal = true;
      await _stockDetailDao.insert(this.stockDetail);
    }
    Navigator.of(_context).pop("refresh");
  }

  materialPick(MaterialPrice data) {
    this.stockDetail.materialid = data.materialid;
    this.stockDetail.materialname = data.materialname;
    notifyListeners();

    this.product.text = data.materialname;
  }
}
