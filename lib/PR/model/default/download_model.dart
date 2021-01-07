import 'package:flutter/material.dart';

enum DOWNLOAD_STATUS { INITIAL, LOADING, SUCCESS, FAILED }

enum DOWNLOAD_TAG {
  CUSTOMER,
  MATERIAL_PRICE,
  LOOKUP,
  INTRODEAL,
  BRAND_COMPETITOR,
  VISIT,
  STOCK,
  SELLIN,
  VISIBILITY,
  POSM,
  TRIAL,
  VISIT_DETAIL,
  STOCK_DETAIL,
  SELLIN_DETAIL,
  VISIBILITY_DETAIL,
  POSM_DETAIL,
}

class DownloadModel {
  int id;
  String title;
  IconData icon;
  Color color;
  int countData;
  DOWNLOAD_STATUS status;
  DOWNLOAD_TAG tag;
  String message;
  String route;

  DownloadModel({
    this.id,
    this.title,
    this.icon,
    this.color,
    this.countData = 0,
    this.tag,
    this.route,
    this.status,
    this.message,
  });



}
