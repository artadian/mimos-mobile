import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/posm.dart';
import 'package:mimos/PR/model/posm_detail.dart';
import 'package:mimos/PR/model/view/posm_detail_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PosmVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  CustomerPR customer = CustomerPR();
  Posm posm;
  List<PosmDetailView> listPosmDetail = [];
  // Dao
  var _posmDao = PosmDao();
  var _posmDetailDao = PosmDetailDao();

  init(CustomerPR customer) async {
    this.customer = customer;
    posm = Posm.createFromJson(customer.toJson());
    await loadPosmHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (posm.id != null) {
      loadListPosm(posm.id);
      refreshController.refreshCompleted();
    }
  }

  loadPosmHead() async {
    var res = await _posmDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        posmdate: customer.tanggalkunjungan);
    print("$runtimeType loadPosmHead: $res");
    if (res != null) {
      posm = res;
      await loadListPosm(res.id);
    }
    notifyListeners();
  }

  loadListPosm(int id) async {
    var res = await _posmDetailDao.getByParent(posmid: id);
    listPosmDetail = res;
    notifyListeners();
  }

  delete(int id) async {
    await _posmDetailDao.delete(id);
    loadPosmHead();
  }

}
