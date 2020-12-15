import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/Constant/listmenu.dart';

class TransactionPRVM with ChangeNotifier {
  List<MyMenuItem> listMenu = [];

  init() {
    _generateListMenu();
  }

  _generateListMenu() {
    listMenu.add(MyMenuItem(
        lambang: Icons.assignment_turned_in_sharp,
        warna: Colors.blue,
        judul: "CEK STOK",
        itemid: "101",
        route: STOK_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.widgets,
        warna: Colors.red,
        judul: "CEK DISPLAY",
        itemid: "102",
        route: DISPLAY_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.shopping_cart,
        warna: Colors.purple,
        judul: "PENJUALAN",
        itemid: "103",
        route: PENJUALAN_SCREEN_PR));
    listMenu.add(MyMenuItem(
        lambang: Icons.assignment,
        warna: Colors.green,
        judul: "POSM",
        itemid: "104",
        route: POSM_SCREEN_PR));
  }
}
