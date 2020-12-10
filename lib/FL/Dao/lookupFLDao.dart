import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mimos/FL/Model/brandCompetitorModelFL.dart';
import 'package:mimos/FL/Model/lookupModelFL.dart';
import 'package:mimos/db/database.dart';
// import 'package:mimos/TF/Model/lookupmodel.dart';
import 'package:sqflite/sqflite.dart';

class LookupFLDao {
  final _dbProvider = DatabaseProvider.dbProvider;

  Future<int> countDataCompetitor() async {
    final db = await _dbProvider.database;
    //var result = await db.rawQuery("SELECT COUNT(*) FROM customer");
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*)  FROM competitor'));
    //print(count);
    return count;
  }

  // cek lookup trial tipe
  Future<List<LookupModelFL>> getSelectLookupType(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct lookupid, lookupvalue, lookupdesc, lookupkey  from lookup where lookupkey = 'trial_type'";
    result = await db.rawQuery(strSQL);
    List<LookupModelFL> trialtype = result.isNotEmpty
        ? result.map((item) => LookupModelFL.fromJson(item)).toList()
        : [];
    return trialtype;
  }
  // end trial tipe

  // cek lookup trial know product
  Future<List<LookupModelFL>> getSelectLookupKnowProduct(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct lookupid, lookupvalue, lookupdesc, lookupkey  from lookup where lookupkey = 'trial_knowing'";
    result = await db.rawQuery(strSQL);
    List<LookupModelFL> trialtype = result.isNotEmpty
        ? result.map((item) => LookupModelFL.fromJson(item)).toList()
        : [];
    return trialtype;
  }
  // end trial know product

  // cek lookup trial taste
  Future<List<LookupModelFL>> getSelectLookupTaste(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct lookupid, lookupvalue, lookupdesc, lookupkey  from lookup where lookupkey = 'trial_taste'";
    result = await db.rawQuery(strSQL);
    List<LookupModelFL> trialtype = result.isNotEmpty
        ? result.map((item) => LookupModelFL.fromJson(item)).toList()
        : [];
    return trialtype;
  }
  // end trial taste

  // cek lookup trial packaging
  Future<List<LookupModelFL>> getSelectLookupPackaging(
      {List<String> columns, String query}) async {
    final db = await _dbProvider.database;
    var strSQL;
    List<Map<String, dynamic>> result;
    strSQL =
        "Select Distinct lookupid, lookupvalue, lookupdesc, lookupkey  from lookup where lookupkey = 'trial_packaging'";
    result = await db.rawQuery(strSQL);
    List<LookupModelFL> trialtype = result.isNotEmpty
        ? result.map((item) => LookupModelFL.fromJson(item)).toList()
        : [];
    return trialtype;
  }
  // end trial packaging
}
