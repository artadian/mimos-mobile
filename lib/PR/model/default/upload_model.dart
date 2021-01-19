import 'package:flutter/material.dart';

enum UPLOAD_STATUS { INITIAL, LOADING, SUCCESS, FAILED, EMPTY, DONE, NEED_SYNC }
enum UPLOAD_TYPE { INSERT, UPDATE, DELETE }

enum UPLOAD_TAG {
  VISIT,
  STOCK,
  SELLIN,
  VISIBILITY,
  POSM,
  STOCK_DETAIL,
  SELLIN_DETAIL,
  VISIBILITY_DETAIL,
  POSM_DETAIL,
  TRIAL,
  CUSTOMER_INTRODEAL,
}

class UploadModel {
  int id;
  String title;
  IconData icon;
  Color color;
  UPLOAD_TAG tag;
  UPLOAD_TAG group;
  UPLOAD_STATUS status;
  UPLOAD_TYPE type;
  String message;
  String route;

  UploadModel({
    this.id,
    this.title,
    this.icon,
    this.color,
    this.group,
    this.tag,
    this.type,
    this.status,
    this.message,
    this.route,
  });

  String getType() {
    return this.type.toString().split(".").last;
  }

  String getTag() {
    return this.tag.toString().split(".").last;
  }

  String getGroup() {
    return this.group.toString().split(".").last;
  }

  String getStatus() {
    return this.status.toString().split(".").last;
  }

  @override
  String toString() {
    return title;
  }

}
