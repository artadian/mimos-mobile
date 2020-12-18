import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisitPRVM with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var _customerDao = CustomerPRDao();
  var _lookupDao = LookupDao();
  var etSearch = TextEditingController();
  List<CustomerPR> listCustomer = [];
  List<Lookup> listReason = [];

  init() async {
    await loadListVisit();
    await loadListReasonNotVisit();
  }

  onRefresh() async {
    print("onRefresh");
    etSearch.text = "";
    await loadListVisit();
    refreshController.refreshCompleted();
  }

  loadListVisit({String search}) async {
    var res = await _customerDao.getCustomerVisit(search: search);
    listCustomer = res;
    notifyListeners();
  }

  loadListReasonNotVisit() async {
    var res = await _lookupDao.getReasonNotVisit();
    listReason = res;
    notifyListeners();
  }

}
