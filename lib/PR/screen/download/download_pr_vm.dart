import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/dao/brand_competitor_pr_dao.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/introdeal_pr_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_pr_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/model/material_price_pr.dart';
import 'package:mimos/PR/repo/download_repo.dart';
import 'package:mimos/helper/session_manager.dart';
import 'package:mimos/helper/extension.dart';

class DownloadItem {
  String title;
  IconData icon;
  int id;
  Color color;
  String route;
  int countData;
  int status; // null: default, -1: error, 0: loading, 1: success

  DownloadItem({
    this.title,
    this.icon,
    this.id,
    this.color,
    this.route,
    this.countData = 0,
    this.status,
  });
}

class DownloadPRVM with ChangeNotifier {
  var etDate = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<DownloadItem> listItemDownload = [];
  var _repo = DownloadRepo();
  var _materialPRDao = MaterialPRDao();
  var _customerPRDao = CustomerPRDao();
  var _lookupDao = LookupDao();
  var _introdealPRDao = IntrodealPRDao();
  var _brandCompetitorPRDao = BrandCompetitorPRDao();
  var _materialPricePRDao = MaterialPricePRDao();
  bool loading = false; // null: default, -1: error, 0: loading, 1: success

  init() async {
    await _generateListMenu();
    notifyListeners();

    setTextDate();
  }

  setTextDate() {
    etDate.text = DateFormat("dd MMMM yyyy").format(selectedDate);
  }

  setStatus(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  downloadAll() async {
    setStatus(true);
    await downloadCustomerOnUser();
    await downloadMaterialPrice();
    await downloadIntrodeal();
    await downloadBrandCompetitor();
    await downloadMaterial();
    await downloadLookup();
    setStatus(false);
    showToast();
  }

  showToast() {
    Fluttertoast.showToast(
        msg: "Download Selesai",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.indigo,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIos: 1);
  }

  setDownloadItemStatus(int index, int status, {int count = 0}) {
    listItemDownload[index].status = status;
    listItemDownload[index].countData = count;
    notifyListeners();
  }

  // Download MATERIAL
  downloadMaterial() async {
    var index = listItemDownload.indexWhere((e) => e.id == 6);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullMaterialPR(
      salesOfficeId: session.salesOfficeId(),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _materialPRDao.truncate();
      _materialPRDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1, count: await _materialPRDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // Download MATERIAL PRICE
  downloadMaterialPrice() async {
    var index = listItemDownload.indexWhere((e) => e.id == 3);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullMaterialPricePR(
      userId: session.userId(),
      date: DateFormat("yyyy-MM-dd").format(selectedDate),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _materialPricePRDao.truncate();
      _materialPricePRDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1, count: await _materialPricePRDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // Download BARANG
  downloadCustomerOnUser() async {
    var index = listItemDownload.indexWhere((e) => e.id == 1);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullCustomerPR(
      userId: session.userId(),
      date: DateFormat("yyyy-MM-dd").format(selectedDate),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _customerPRDao.truncate();
      _customerPRDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1, count: await _customerPRDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // Download LOOKUP
  downloadLookup() async {
    var index = listItemDownload.indexWhere((e) => e.id == 7);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullLookup(
      userId: session.userId(),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _lookupDao.truncate();
      _lookupDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1, count: await _lookupDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // Download INTRODEAL
  downloadIntrodeal() async {
    var index = listItemDownload.indexWhere((e) => e.id == 4);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullIntrodealPR(
      userId: session.userId(),
      date: DateFormat("yyyy-MM-dd").format(selectedDate),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _introdealPRDao.truncate();
      _introdealPRDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1, count: await _introdealPRDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // Download BRAND COMPETITOR
  downloadBrandCompetitor() async {
    var index = listItemDownload.indexWhere((e) => e.id == 5);
    // Loading
    setDownloadItemStatus(index, 0);

    var response = await _repo.pullBrandCompetitorPR(
      salesOfficeId: session.salesOfficeId(),
    );

    print(response.status);
    if (response.status) {
      print(response.message);
      _brandCompetitorPRDao.truncate();
      _brandCompetitorPRDao.insertAll(response.list);
      // Success
      setDownloadItemStatus(index, 1,
          count: await _brandCompetitorPRDao.count());
    } else {
      print(response.message);
      // Error
      setDownloadItemStatus(index, -1);
    }
  }

  // LIST MENU DOWNLOAD
  _generateListMenu() async {
    listItemDownload.add(DownloadItem(
      id: 1,
      title: "Download Customer/Kunjungan",
      icon: Icons.person,
      color: Colors.red,
      countData: await _customerPRDao.count(),
    ));
    listItemDownload.add(DownloadItem(
      id: 2,
      title: "Download Item Barang",
      icon: Icons.widgets,
      color: Colors.green,
    ));
    listItemDownload.add(DownloadItem(
      id: 3,
      title: "Download Harga Barang",
      icon: Icons.monetization_on,
      color: Colors.blue,
      countData: await _materialPricePRDao.count(),
    ));
    listItemDownload.add(DownloadItem(
      id: 4,
      title: "Download Introdeal",
      icon: Icons.assignment_turned_in,
      color: Colors.orange,
      countData: await _introdealPRDao.count(),
    ));
    listItemDownload.add(DownloadItem(
      id: 5,
      title: "Download Kompetitor",
      icon: Icons.assignment_ind,
      color: Colors.purple,
      countData: await _brandCompetitorPRDao.count(),
    ));
    listItemDownload.add(DownloadItem(
      id: 6,
      title: "Download Material",
      icon: Icons.ad_units,
      color: Colors.cyan,
      countData: await _materialPRDao.count(),
    ));
    listItemDownload.add(DownloadItem(
      id: 7,
      title: "Download Lookup",
      icon: Icons.margin,
      color: Colors.brown,
      countData: await _lookupDao.count(),
    ));
  }
}
