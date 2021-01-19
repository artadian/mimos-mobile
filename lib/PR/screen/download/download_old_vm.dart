//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:intl/intl.dart';
//import 'package:mimos/PR/dao/brand_competitor_dao.dart';
//import 'package:mimos/PR/dao/customer_pr_dao.dart';
//import 'package:mimos/PR/dao/introdeal_dao.dart';
//import 'package:mimos/PR/dao/lookup_dao.dart';
//import 'package:mimos/PR/dao/material_pr_dao.dart';
//import 'package:mimos/PR/dao/material_price_dao.dart';
//import 'package:mimos/PR/dao/sellin_dao.dart';
//import 'package:mimos/PR/dao/sellin_detail_dao.dart';
//import 'package:mimos/PR/dao/stock_dao.dart';
//import 'package:mimos/PR/dao/stock_detail_dao.dart';
//import 'package:mimos/PR/dao/visit_dao.dart';
//import 'package:mimos/PR/model/material_price_pr.dart';
//import 'package:mimos/helper/session_manager.dart';
//import 'package:mimos/helper/extension.dart';
//import 'package:mimos/utils/widget/my_toast.dart';
//
//class DownloadItem {
//  String title;
//  IconData icon;
//  int id;
//  Color color;
//  String route;
//  int countData;
//  int status; // null: default, -1: error, 0: loading, 1: success
//  String message;
//
//  DownloadItem({
//    this.title,
//    this.icon,
//    this.id,
//    this.color,
//    this.route,
//    this.countData = 0,
//    this.status,
//    this.message,
//  });
//}
//
//class DownloadPRVM with ChangeNotifier {
//  var etDate = TextEditingController();
//  DateTime selectedDate = DateTime.now();
//  List<DownloadItem> listItemDownload = [];
//  var _repo = DownloadRepo();
//  var _materialPRDao = MaterialPRDao();
//  var _customerPRDao = CustomerPRDao();
//  var _lookupDao = LookupDao();
//  var _introdealPRDao = IntrodealPRDao();
//  var _brandCompetitorPRDao = BrandCompetitorPRDao();
//  var _materialPriceDao = MaterialPriceDao();
//  var _visitDao = VisitDao();
//  var _stockDao = StockDao();
//  var _stockDetailDao = StockDetailDao();
//  var _sellinDao = SellinDao();
//  var _sellinDetailDao = SellinDetailDao();
//  bool loading = false; // null: default, -1: error, 0: loading, 1: success
//
//  init() async {
//    await _generateListMenu();
//    notifyListeners();
//
//    setTextDate();
//  }
//
//  setTextDate() {
//    etDate.text = DateFormat("dd MMMM yyyy").format(selectedDate);
//  }
//
//  setStatus(bool loading) {
//    this.loading = loading;
//    notifyListeners();
//  }
//
//  downloadAll() async {
//    setStatus(true);
//    await downloadCustomerOnUser();
//    await downloadVisit();
//    await downloadMaterialPrice();
//    await downloadIntrodeal();
//    await downloadBrandCompetitor();
////    await downloadMaterial();
//    await downloadLookup();
//    setStatus(false);
//    showToast();
//  }
//
//  showToast() {
//    MyToast.showToast("Download Selesai");
//  }
//
//  setDownloadItemStatus(int index,
//      {int status, String message, int count = 0}) {
//    listItemDownload[index].status = status;
//    listItemDownload[index].countData = count;
//    listItemDownload[index].message = message;
//    notifyListeners();
//  }
//
//  // Download MATERIAL
//  downloadMaterial() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 6);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullMaterialPR(
//      salesOfficeId: session.salesOfficeId(),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _materialPRDao.truncate();
//      await _materialPRDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _materialPRDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download MATERIAL PRICE
//  downloadMaterialPrice() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 3);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullMaterialPrice(
//      salesOfficeId: session.salesOfficeId(),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _materialPriceDao.truncate();
//      await _materialPriceDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _materialPriceDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download BARANG
//  downloadCustomerOnUser() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 1);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullCustomerPR(
//      userId: await session.getUserId(),
//      date: DateFormat("yyyy-MM-dd").format(selectedDate),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _customerPRDao.truncate();
//      await _customerPRDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _customerPRDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download LOOKUP
//  downloadLookup() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 7);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullLookup(
//      userId: await session.getUserId(),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _lookupDao.truncate();
//      await _lookupDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _lookupDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download INTRODEAL
//  downloadIntrodeal() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 4);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullIntrodealPR(
//      userId: await session.getUserId(),
//      date: DateFormat("yyyy-MM-dd").format(selectedDate),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _introdealPRDao.truncate();
//      await _introdealPRDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _introdealPRDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download BRAND COMPETITOR
//  downloadBrandCompetitor() async {
//    var index = listItemDownload.indexWhere((e) => e.id == 5);
//    // Loading
//    setDownloadItemStatus(index, status: 0);
//
//    var response = await _repo.pullBrandCompetitorPR(
//      salesOfficeId: session.salesOfficeId(),
//    );
//
//    print(response.status);
//    if (response.status) {
//      print(response.message);
//      await _brandCompetitorPRDao.truncate();
//      await _brandCompetitorPRDao.insertAll(response.list);
//      // Success
//      setDownloadItemStatus(index,
//          status: 1,
//          message: response.message,
//          count: await _brandCompetitorPRDao.count());
//    } else {
//      print(response.message);
//      // Error
//      setDownloadItemStatus(index, status: -1, message: response.message);
//    }
//  }
//
//  // Download KUNJUNGAN
//  downloadVisit() async {
//    // VISIT
//    var resVisit = await _repo.pullVisit(
//      userId: await session.getUserId(),
//      date: DateFormat("yyyy-MM-dd").format(selectedDate),
//    );
//    if (resVisit.status) {
//      print(resVisit.message);
//      await _visitDao.truncate();
//      await _visitDao.insertAll(resVisit.list);
//    } else {
//      print(resVisit.message);
//    }
//
//    // STOCK
//    var resStock = await _repo.pullStock(
//      userId: await session.getUserId(),
//      date: DateFormat("yyyy-MM-dd").format(selectedDate),
//    );
//    if (resVisit.status) {
//      print(resVisit.message);
//      await _stockDao.truncate();
//      await _stockDao.insertAll(resStock.list);
//    } else {
//      print(resVisit.message);
//    }
//    // STOCK DETAIL
//    var stockIds = await _stockDao.getAllPrimaryKey();
//    var resStockDetail = await _repo.pullStockDetail(
//      stockIds: stockIds,
//    );
//    if (resVisit.status) {
//      print(resVisit.message);
//      await _stockDetailDao.truncate();
//      await _stockDetailDao.insertAll(resStockDetail.list);
//    } else {
//      print(resVisit.message);
//    }
//
//    // SELLIN
//    var resSellin = await _repo.pullSellin(
//      userId: await session.getUserId(),
//      date: DateFormat("yyyy-MM-dd").format(selectedDate),
//    );
//    if (resVisit.status) {
//      print(resVisit.message);
//      await _sellinDao.truncate();
//      await _sellinDao.insertAll(resSellin.list);
//    } else {
//      print(resVisit.message);
//    }
//    // SELLIN DETAIL
//    var sellinIds = await _sellinDao.getAllPrimaryKey();
//    var resSellinDetail = await _repo.pullSellinDetail(
//      sellinIds: sellinIds,
//    );
//    if (resVisit.status) {
//      print(resVisit.message);
//      await _sellinDetailDao.truncate();
//      await _sellinDetailDao.insertAll(resSellinDetail.list);
//    } else {
//      print(resVisit.message);
//    }
//  }
//
//  // LIST MENU DOWNLOAD
//  _generateListMenu() async {
//    listItemDownload.add(DownloadItem(
//      id: 1,
//      title: "Download Customer",
//      icon: Icons.person,
//      color: Colors.red,
//      countData: await _customerPRDao.count(),
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 2,
//      title: "Download Item Barang",
//      icon: Icons.widgets,
//      color: Colors.green,
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 3,
//      title: "Download Harga Barang",
//      icon: Icons.monetization_on,
//      color: Colors.blue,
//      countData: await _materialPriceDao.count(),
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 4,
//      title: "Download Introdeal",
//      icon: Icons.assignment_turned_in,
//      color: Colors.orange,
//      countData: await _introdealPRDao.count(),
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 5,
//      title: "Download Kompetitor",
//      icon: Icons.assignment_ind,
//      color: Colors.purple,
//      countData: await _brandCompetitorPRDao.count(),
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 6,
//      title: "Download Material",
//      icon: Icons.ad_units,
//      color: Colors.cyan,
//      countData: await _materialPRDao.count(),
//    ));
//    listItemDownload.add(DownloadItem(
//      id: 7,
//      title: "Download Lookup",
//      icon: Icons.margin,
//      color: Colors.brown,
//      countData: await _lookupDao.count(),
//    ));
//  }
//}
