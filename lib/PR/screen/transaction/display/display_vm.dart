import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DisplayVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  CustomerPR customer = CustomerPR();
  VisibilityModel visibility;
  List<VisibilityDetail> listVisibilityDetail = [];
  // Dao
  var _visibilityDao = VisibilityDao();
  var _visibilityDetailDao = VisibilityDetailDao();

  init(CustomerPR customer) async {
    this.customer = customer;
    visibility = VisibilityModel.createFromJson(customer.toJsonView());
    await loadVisibilityHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (visibility.id != null) {
      loadListVisibility(visibility.id);
      refreshController.refreshCompleted();
    }
  }

  loadVisibilityHead() async {
    var res = await _visibilityDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        visibilitydate: customer.tanggalkunjungan);
    print("$runtimeType loadVisibilityHead: $res");
    if (res != null) {
      visibility = res;
      await loadListVisibility(res.id);
    }
    notifyListeners();
  }

  loadListVisibility(int id) async {
    var res = await _visibilityDetailDao.getByParent(visibilityid: id);
    listVisibilityDetail = res;
    notifyListeners();
  }

  delete(int id) async {
    await _visibilityDetailDao.delete(id);
    loadVisibilityHead();
  }

}
