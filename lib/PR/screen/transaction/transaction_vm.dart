import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/lookup.dart';
import 'package:mimos/PR/model/sellin.dart';

class TransactionVM with ChangeNotifier {
  List<MyMenuItem> listMenu = [];
  CustomerPR customer = CustomerPR();
  List<Lookup> listReason = [];
  var saving; // null: default, -1: error, 0: loading, 1: success
  var _lookupDao = LookupDao();
  var _sellinDao = SellinDao();
  Sellin sellin;

  init(CustomerPR customer) async {
    this.customer = customer;
    await loadSellinHead();
    await loadListReasonNotVisit();
    _generateListMenu();
    notifyListeners();
  }

  loadSellinHead() async {
    var res = await _sellinDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        sellindate: customer.tanggalkunjungan);
    print("$runtimeType loadSellinHead: $res}");
    if (res != null) {
      sellin = res;
    }
    notifyListeners();
  }

  loadListReasonNotVisit() async {
    var res = await _lookupDao.getReasonNotVisit();
    listReason = res;
    notifyListeners();
  }

  Future<bool> saveSellin({String idReason}) async {
    if(idReason != null){
      customer.notvisitreason = idReason;
    }else{
      customer.notvisitreason = "0";
    }
    Sellin sellin = Sellin.createFromJson(customer.toJson());
    print(sellin.toJson());
    saving = 0; // Loading
    notifyListeners();

    var res = await _sellinDao.insert(sellin);
    if(res != null){
      saving = 1; // Success
      notifyListeners();
      return true;
    }else {
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
        warna: Colors.red,
        judul: "CEK DISPLAY",
        itemid: "102",
        route: DISPLAY_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.shopping_cart,
        warna: Colors.purple,
        judul: "PENJUALAN",
        itemid: "103",
        route: PENJUALAN_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.assignment,
        warna: Colors.green,
        judul: "POSM",
        itemid: "104",
        route: POSM_SCREEN_PR));
  }
}
