import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_pr_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/PR/model/trial.dart';

class TrialFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  StockDetail stockDetail = StockDetail();
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
  var _materialDao = MaterialPRDao();
  var _stockDetailDao = StockDetailDao();
  var model = Trial();

  init() async {
    notifyListeners();
  }

  // --------------------- FORM SCREEN -----------------------
  loadStockDetailForm(int id) async {
    var res = await _stockDetailDao.getById(id);
    stockDetail = res;
    setForm();
  }

  setForm() {
    product.text = stockDetail.materialname;
  }


}
