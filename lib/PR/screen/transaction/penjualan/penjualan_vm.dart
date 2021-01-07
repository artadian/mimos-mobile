import 'package:flutter/material.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/model/customer_pr.dart';
import 'package:mimos/PR/model/sellin.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:mimos/utils/widget/my_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PenjualanVM with ChangeNotifier {
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  var etNota = TextEditingController();
  CustomerPR customer = CustomerPR();
  Sellin sellin;
  List<SellinDetail> listSellinDetail = [];
  // Dao
  var _sellinDao = SellinDao();
  var _sellinDetailDao = SellinDetailDao();
  var focusNode = FocusNode();
  BuildContext _context;
  double amount = 0.0;

  init(BuildContext context, CustomerPR customer) async {
    this._context = context;
    this.customer = customer;
    await loadSellinHead();
    notifyListeners();
  }

  onRefresh() {
    print("onRefresh");
    if (sellin.id != null) {
      loadListSellin(sellin.id);
      refreshController.refreshCompleted();
    }
  }

  loadSellinHead() async {
    sellin = Sellin.createFromJson(customer.toJson());
    var res = await _sellinDao.getByVisit(
        userid: customer.userid,
        customerno: customer.customerno,
        sellindate: customer.tanggalkunjungan);
    print("$runtimeType loadSellinHead: $res}");
    if (res != null) {
      sellin = res;
      etNota.text = res.sellinno;
      loadListSellin(res.id);
    }
    notifyListeners();
  }

  loadListSellin(int id) async {
    var res = await _sellinDetailDao.getByParent(sellinid: id);
    listSellinDetail = res;
    res.forEach((element) {
      print(element.toJson());
    });
    amount = listSellinDetail.fold(0.0, (sum, item) => sum + item.sellinvalue);
    print("amount: $amount");
    notifyListeners();
  }

  bool notaIsEmpty(){
    if(etNota.text.isEmpty){
      MyToast.showToast("NOTA tidak boleh kosong",
          backgroundColor: Colors.red);
      focusNode.requestFocus();
      return true;
    }
    return false;
  }

  save() async {
    if(notaIsEmpty()){
      return;
    }

    sellin.needSync = true;
    sellin.sellinno = etNota.text;
    var res = await _sellinDao.update(sellin);
    if(res != null){
      MyToast.showToast("Berhasi menyimpan data",
          backgroundColor: Colors.green);
    }
    Navigator.of(_context).pop("refresh");
  }

  delete(int id) async {
    await _sellinDao.delete(id);
    await _sellinDetailDao.deleteBySellin(id.toString());
    loadSellinHead();
    Navigator.of(_context).pop("refresh");
  }

}
