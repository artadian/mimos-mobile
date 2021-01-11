import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/sellin.dart';

class TransactionVM with ChangeNotifier {
  List<MyMenuItem> listMenu = [];
  CustomerPR customer = CustomerPR();
  List<Lookup> listReason = [];
  var saving; // null: default, -1: error, 0: loading, 1: success
  var _visitDao = VisitDao();
  var _lookupDao = LookupDao();
  var _sellinDao = SellinDao();
  var loading = false;
  Sellin sellin;

  init(CustomerPR customer) async {
    loading = true;
    notifyListeners();

    _generateListMenu();
    await loadSellinHead(customer.idvisit);
    await loadListReasonNotBuy();
    loading = false;
    notifyListeners();
  }

  loadSellinHead(int idVisit) async {
    this.customer = await _visitDao.getByIdVisit(idVisit);
    var res = await _sellinDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        sellindate: customer.tanggalkunjungan);
    print("$runtimeType loadSellinHead: $res}");
    if (res != null) {
      sellin = res;
    } else {
      sellin = null;
    }
    setColorItemSellin(customer);
    notifyListeners();
  }

  setColorItemSellin(CustomerPR customer) {
    var i = listMenu.indexWhere((e) => e.itemid == "103");
    if (sellin != null &&
        (customer.notbuyreason == null || customer.notbuyreason == "0")) {
      listMenu[i].warna = Colors.green;
    } else if (customer.notbuyreason != null && customer.notbuyreason != "0") {
      listMenu[i].warna = Colors.red;
    } else {
      listMenu[i].warna = Colors.grey;
    }
  }

  loadListReasonNotBuy() async {
    var res = await _lookupDao.getReasonNotBuy();
    listReason = res;
    notifyListeners();
  }

  Future<bool> saveSellin({String idReason}) async {
    if (idReason != null) {
      _visitDao.setNotBuyReason(id: customer.idvisit, notBuyReason: idReason);
      return true;
    } else {
      _visitDao.setNotBuyReason(id: customer.idvisit, notBuyReason: "0");
    }

    Sellin sellin = Sellin.createFromJson(customer.toJsonView());
    print(sellin.toJson());
    saving = 0; // Loading
    notifyListeners();

    var res = await _sellinDao.insert(sellin);
    loadSellinHead(customer.idvisit);
    if (res != null) {
      saving = 1; // Success
      notifyListeners();
      return true;
    } else {
      saving = 1; // Success
      notifyListeners();
      return false;
    }
  }

  _generateListMenu() {
    listMenu.add(MyMenuItem(
        lambang: Icons.assignment_turned_in_sharp,
        warna: Colors.blue,
        judul: "CEK STOK",
        itemid: "101",
        route: STOK_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.widgets,
        warna: Colors.purple,
        judul: "CEK DISPLAY",
        itemid: "102",
        route: DISPLAY_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.shopping_cart,
        warna: Colors.grey[700],
        judul: "PENJUALAN",
        itemid: "103",
        route: PENJUALAN_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.assignment,
        warna: Colors.deepPurple,
        judul: "POSM",
        itemid: "104",
        route: POSM_SCREEN_PR));
  }
}
