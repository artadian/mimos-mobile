import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/stock.dart';
import 'package:mimos/PR/model/stock_detail.dart';
import 'package:mimos/PR/model/visibility_detail.dart';
import 'package:mimos/PR/model/visibility_model.dart';
import 'package:mimos/PR/model/visit.dart';
import 'package:mimos/PR/screen/transaction/transaction_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class VisitVM with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var _customerDao = CustomerPRDao();
  var _lookupDao = LookupDao();
  var _visitDao = VisitDao();
  var _materialPriceDao = MaterialPriceDao();
  var etSearch = TextEditingController();
  var saving; // null: default, -1: error, 0: loading, 1: success
  List<CustomerPR> listCustomer = [];
  List<Lookup> listReason = [];
  BuildContext context;

  init(BuildContext context) async {
    this.context = context;
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
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    var res = await _customerDao.getCustomerVisit(date: date, search: search);
//    var res = await _customerDao.getAll();
    listCustomer = res;
    notifyListeners();
  }

  loadListReasonNotVisit() async {
    var res = await _lookupDao.getReasonNotVisit();
    listReason = res;
    notifyListeners();
  }

  saveVisit(CustomerPR customer, {String idReason}) async {
    Visit visit = Visit.createFromJson(customer.toJsonView());
    if (idReason != null) {
      visit.notvisitreason = idReason;
    } else {
      visit.notvisitreason = "0";
    }
    print(visit.toJson());
    // Loading
    saving = 0;
    notifyListeners();

    var id = await _visitDao.insert(visit);
    var data = await _visitDao.getByIdVisit(id);
    if (idReason == null) {
      await saveDefaultStockAndDisplay(customer);
    }
    if (id != null) {
      saving = 1; // Success
    } else {
      saving = -1; // Failed
    }
    onRefresh();
    notifyListeners();
    if (idReason == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransactionScreen(data)),
      );
    }
  }

  saveDefaultStockAndDisplay(CustomerPR customer) async {
    var _stockDao = StockDao();
    var _visibilityDao = VisibilityDao();

    Stock stock = Stock.createFromJson(customer.toJsonView());
    VisibilityModel visibility =
        VisibilityModel.createFromJson(customer.toJsonView());

    var material = await _materialPriceDao.getByPriceIdCust(customer.priceid);

    var stockid = await _stockDao.insert(stock);
    var visibilityid = await _visibilityDao.insert(visibility);

    var _stockDetailDao = StockDetailDao();
    var _visibilityDetailDao = VisibilityDetailDao();

    material.forEach((m) async {
      var sd = StockDetail.create(
        stockid: stockid,
        materialid: m.materialid,
        materialname: m.materialname,
      );
      await _stockDetailDao.insert(sd);

      var vd = VisibilityDetail.create(
        visibilityid: visibilityid,
        materialid: m.materialid,
        materialname: m.materialname,
      );
      await _visibilityDetailDao.insert(vd);
    });
  }

}
