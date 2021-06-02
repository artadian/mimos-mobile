import 'package:mimos/PR/screen/upload/resource/posm_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/posm_res.dart';
import 'package:mimos/PR/screen/upload/resource/sellin_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/sellin_res.dart';
import 'package:mimos/PR/screen/upload/resource/stock_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/stock_res.dart';
import 'package:mimos/PR/screen/upload/resource/trial_res.dart';
import 'package:mimos/PR/screen/upload/resource/visibility_detail_res.dart';
import 'package:mimos/PR/screen/upload/resource/visibility_res.dart';
import 'package:mimos/PR/screen/upload/resource/visit_res.dart';

class SyncResource {
  var _visitRes = VisitRes();
  var _stockRes = StockRes();
  var _stockDetailRes = StockDetailRes();
  var _sellinRes = SellinRes();
  var _sellinDetailRes = SellinDetailRes();
  var _posmRes = PosmRes();
  var _posmDetailRes = PosmDetailRes();
  var _visibilityRes = VisibilityRes();
  var _visibilityDetailRes = VisibilityDetailRes();
  var _trialRes = TrialRes();

  upload() async {
    await syncInsert();
    await syncUpdate();
    await syncDelete();
  }

  syncInsert() async {
    // Visit
    await _visitRes.insert().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Trial
    await _trialRes.insert().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Stock
    await _stockRes.insert().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    if (!await _stockRes.needSync()) {
      // Stock Detail
      await _stockDetailRes.insert().listen((e) {
        print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
      }).asFuture();
    }
    // Sellin
    // await _sellinRes.insert().listen((e) {
    //   print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    // }).asFuture();
    // if (!await _sellinRes.needSync()) {
    //   // Sellin Detail
    //   await _sellinDetailRes.insert().listen((e) {
    //     print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    //   }).asFuture();
    // }
    // Posm
    await _posmRes.insert().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    if (!await _posmRes.needSync()) {
      // Posm Detail
      await _posmDetailRes.insert().listen((e) {
        print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
      }).asFuture();
    }
    // Visibility
    await _visibilityRes.insert().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    if (!await _visibilityRes.needSync()) {
      // Visibility Detail
      await _visibilityDetailRes.insert().listen((e) {
        print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
      }).asFuture();
    }

  }

  syncUpdate() async {
    // Visit
    await _visitRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Trial
    await _trialRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Stock
    await _stockRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Stock Detail
    await _stockDetailRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Sellin
    // await _sellinRes.update().listen((e) {
    //   print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    // }).asFuture();
    // // Sellin Detail
    // await _sellinDetailRes.update().listen((e) {
    //   print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    // }).asFuture();
    // Posm
    await _posmRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Posm Detail
    await _posmDetailRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Visibility
    await _visibilityRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Visibility Detail
    await _visibilityDetailRes.update().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
  }

  syncDelete() async {
    // Visit
    await _visitRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Trial
    await _trialRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Stock
    await _stockRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Stock Detail
    await _stockDetailRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Sellin
    // await _sellinRes.delete().listen((e) {
    //   print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    // }).asFuture();
    // // Sellin Detail
    // await _sellinDetailRes.delete().listen((e) {
    //   print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    // }).asFuture();
    // Posm
    await _posmRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Posm Detail
    await _posmDetailRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Visibility
    await _visibilityRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
    // Visibility Detail
    await _visibilityDetailRes.delete().listen((e) {
      print("UPLOAD: ${e.title} - ${e.status}: ${e.message}");
    }).asFuture();
  }
}