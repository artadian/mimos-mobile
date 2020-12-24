import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/visit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisitVM with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var _customerDao = CustomerPRDao();
  var _lookupDao = LookupDao();
  var _visitDao = VisitDao();
  var etSearch = TextEditingController();
  var saving; // null: default, -1: error, 0: loading, 1: success
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

  saveVisit(CustomerPR customer, {String idReason}) async {
    if(idReason != null){
      customer.notvisitreason = idReason;
    }else{
      customer.notvisitreason = "0";
    }
    Visit visit = Visit.createFromJson(customer.toJson());
    print(visit.toJson());
    // Loading
    saving = 0;
    notifyListeners();

    var res = await _visitDao.insert(visit);
    if(res != null){
      saving = 1; // Success
    }else {
      saving = -1; // Failed
    }
    onRefresh();
    notifyListeners();
  }

}
