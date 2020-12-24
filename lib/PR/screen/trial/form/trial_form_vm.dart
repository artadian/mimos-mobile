import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/material_pr_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/model/stock_detail.dart';

class TrialFormVM with ChangeNotifier {
  var saving; // null: default, -1: error, 0: loading, 1: success
  StockDetail stockDetail = StockDetail();
  // Form
  final keyForm = GlobalKey<FormState>();
  var product = TextEditingController();
  var pac = TextEditingController();
  var slof = TextEditingController();
  var bal = TextEditingController();
  // Dao
  var _materialDao = MaterialPRDao();
  var _stockDetailDao = StockDetailDao();

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
    pac.text = stockDetail.materialname;
    slof.text = stockDetail.materialname;
    bal.text = stockDetail.materialname;
  }


}
