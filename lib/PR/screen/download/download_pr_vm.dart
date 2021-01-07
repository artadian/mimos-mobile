import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimos/PR/model/default/download_model.dart';
import 'package:mimos/PR/screen/download/resource/pull_brand_competitor.dart';
import 'package:mimos/PR/screen/download/resource/pull_customer.dart';
import 'package:mimos/PR/screen/download/resource/pull_lookup.dart';
import 'package:mimos/PR/screen/download/resource/pull_material_price.dart';
import 'package:mimos/PR/screen/download/resource/pull_posm.dart';
import 'package:mimos/PR/screen/download/resource/pull_sellin.dart';
import 'package:mimos/PR/screen/download/resource/pull_stock.dart';
import 'package:mimos/PR/screen/download/resource/pull_trial.dart';
import 'package:mimos/PR/screen/download/resource/pull_visibility.dart';
import 'package:mimos/PR/screen/download/resource/pull_visit.dart';
import 'package:mimos/utils/widget/my_toast.dart';

class DownloadPRVM with ChangeNotifier {
  var etDate = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<DownloadModel> downloads = [];
  bool loading = false; // null: default, -1: error, 0: loading, 1: success
  var _customer = PullCustomer();
  var _materialPrice = PullMaterialPrice();
  var _lookup = PullLookup();
  var _brandCompetitor = PullBrandCompetitor();
  var _visit = PullVisit();
  var _stock = PullStock();
  var _posm = PullPosm();
  var _visibility = PullVisibility();
  var _sellin = PullSellin();
  var _trial = PullTrial();

  init() async {
    downloads.add(await _customer.init());
    downloads.add(await _materialPrice.init());
    downloads.add(await _lookup.init());
    downloads.add(await _brandCompetitor.init());
    downloads.add(await _visit.init());
    downloads.add(await _stock.init());
    downloads.add(await _posm.init());
    downloads.add(await _visibility.init());
    downloads.add(await _sellin.init());
    downloads.add(await _trial.init());
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
    var date = DateFormat("yyyy-MM-dd").format(selectedDate);

    await _customer.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _materialPrice.download().listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _lookup.download().listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _brandCompetitor.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _visit.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _stock.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _posm.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _visibility.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _sellin.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    await _trial.download(date: date).listen((e) {
      print("DOWNLOAD: ${e.title} - ${e.status}: ${e.message}");
      var i = downloads.indexWhere((v) => v.tag == e.tag);
      downloads[i] = e;
      notifyListeners();
    }).asFuture();

    setStatus(false);
    showToast();
  }

  showToast() {
    MyToast.showToast("Download Selesai");
  }
}
