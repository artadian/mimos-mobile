import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/trial_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrialVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  CustomerPR customer = CustomerPR();
  Trial trial;
  List<Trial> listTrial = [];
  var _trialDao = TrialDao();

  init(CustomerPR customer) async {
    this.customer = customer;
//    trial = Trial.createFromJson(customer.toJsonView());
//    await loadTrialHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (trial.id != null) {
//      loadListTrial(trial.id);
      refreshController.refreshCompleted();
    }
  }

//  loadTrialHead() async {
//    var res = await _trialDao.getByVisit(
//        userid: customer.userid,
//        customerno: customer.customerno,
//        trialdate: customer.tanggalkunjungan);
//    print("$runtimeType loadTrialHead: $res");
//    if (res != null) {
//      trial = res;
//      await loadListTrial(res.id);
//    }
//    notifyListeners();
//  }
//
//  loadListTrial(int id) async {
//    var res = await _trialDao.getByParent(trialid: id);
//    listTrial = res;
//    notifyListeners();
//  }

  delete(int id) async {
    await _trialDao.delete(id);
//    loadTrialHead();
  }

}
