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

  init() async {
    this.customer = customer;
    loadListTrial();
//    trial = Trial.createFromJson(customer.toJsonView());
//    await loadTrialHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    refreshController.refreshCompleted();
  }

  loadListTrial() async {
    var res = await _trialDao.getAll();
    listTrial = res;
    notifyListeners();
  }

  delete(int id) async {
    await _trialDao.delete(id);
//    loadTrialHead();
  }

}
