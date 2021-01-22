import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/trial_dao.dart';
import 'package:mimos/PR/model/trial.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrialVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  Trial trial;
  List<Trial> listTrial = [];
  var _trialDao = TrialDao();
  var totalTrial = 0;
  var packSold = 0;
  var amount = 0.0;

  init() async {
    loadData();
  }

  loadData(){
    loadListTrial();
    loadResume();
  }

  onRefresh() {
    print("onRefresh");
    loadData();
    refreshController.refreshCompleted();
  }

  loadListTrial() async {
    var res = await _trialDao.getAllTrial();
    listTrial = res;
    notifyListeners();
  }

  loadResume() async {
    var res = await _trialDao.getAllTrial();
    totalTrial = res.length;
    packSold = res.fold(0, (p, c) => p + c.qty);
    amount = res.fold(0, (p, c) => p + c.amount);
    notifyListeners();
  }

  delete(int id) async {
    await _trialDao.delete(id);
    loadData();
  }

}
