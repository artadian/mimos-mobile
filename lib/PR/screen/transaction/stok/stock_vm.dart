import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  CustomerPR customer = CustomerPR();
  Stock stock;
  List<StockDetail> listStockDetail = [];
  // Dao
  var _stockDao = StockDao();
  var _stockDetailDao = StockDetailDao();

  init(CustomerPR customer) async {
    this.customer = customer;
    stock = Stock.createFromJson(customer.toJsonView());
    await loadStockHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (stock.id != null) {
      loadListStock(stock.id);
      refreshController.refreshCompleted();
    }
  }

  loadStockHead() async {
    var res = await _stockDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        stockdate: customer.tanggalkunjungan);
    print("$runtimeType loadStockHead: $res");
    if (res != null) {
      stock = res;
      await loadListStock(res.id);
    }
    notifyListeners();
  }

  loadListStock(int id) async {
    var res = await _stockDetailDao.getByParent(stockid: id);
    listStockDetail = res;
    notifyListeners();
  }

  delete(int id) async {
    await _stockDetailDao.delete(id);
    loadStockHead();
  }

}
