import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PenjualanVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  var etNota = TextEditingController();
  CustomerPR customer = CustomerPR();
  Sellin sellin;
  List<SellinDetail> listSellinDetail = [];
  // Dao
  var _sellinDao = SellinDao();
  var _sellinDetailDao = SellinDetailDao();

  init(CustomerPR customer) async {
    this.customer = customer;
    sellin = Sellin.createFromJson(customer.toJson());
    await loadSellinHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (sellin.id != null) {
      loadListSellin(sellin.id);
      refreshController.refreshCompleted();
    }
  }

  loadSellinHead() async {
    var res = await _sellinDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        sellindate: customer.tanggalkunjungan);
    print("$runtimeType loadSellinHead: $res}");
    if (res != null) {
      sellin = res;
      loadListSellin(res.id);
    }
    notifyListeners();
  }

  loadListSellin(int id) async {
    var res = await _sellinDetailDao.getByParent(sellinid: id);
    listSellinDetail = res;
    res.forEach((element) {
      print(element.toJson());
    });
    notifyListeners();
  }

  save() async {

  }

  delete(int id) async {
    await _sellinDetailDao.delete(id);
    onRefresh();
  }

}
