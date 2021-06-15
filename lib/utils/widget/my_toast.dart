import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  static showToast(String message,
      {Color backgroundColor,
      Color textColor,
      Toast toastLength,
      double fontSize,
      int timeInSecForIos}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: backgroundColor ?? Colors.indigo,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 1);
  }
}
