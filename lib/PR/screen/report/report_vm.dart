import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';
import 'package:mimos/PR/model/sellin_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportVM with ChangeNotifier {
  DateTime now = DateTime.now();
  String nowStr;
  var _customerDao = CustomerPRDao();
  var _visitDao = VisitDao();
  var _sellinDao = SellinDao();
  var _sellinDetailDao = SellinDetailDao();

  var kunjungan = 0;
  var dikunjungi = 0;
  var tidakDikunjungi = 0;
  var tanpaPenjualan = 0;
  var notaPenjualan = 0;
  var totalPacTerjual = 0;
  var totalPenjualan = 0.0;
  List<SellinDetail> listSellinDetail = [];

  init() {
    nowStr = DateFormat("yyyy-MM-dd").format(now);
    loadDashVisit();
  }

  loadDashVisit() async {
    // Customer
    var cust = await _customerDao.getAllByDate(date: nowStr);
    kunjungan = cust.length;
    // Count Dikunjungi
    var countVisited = await _visitDao.countVisited(date: nowStr);
    dikunjungi = countVisited;
    // Count Not Visited
    var countNotVisited = await _visitDao.countNotVisited(date: nowStr);
    tidakDikunjungi = countNotVisited;
    // Sellin
    var sellin = await _sellinDao.getAllByDate(date: nowStr);
    notaPenjualan = sellin.length;
    tanpaPenjualan = dikunjungi - notaPenjualan;
    // Sellin Detail
    var sellinDetail = await _sellinDetailDao.getByManyParent(
        sellinids: sellin.map((e) => e.id).toList());
    listSellinDetail = sellinDetail;
    totalPacTerjual = sellinDetail.fold(0, (sum, item) => sum + item.qty);
    totalPenjualan = sellinDetail.fold(0.0, (sum, item) => sum + item.sellinvalue);
    notifyListeners();
  }

}
