import 'package:flutter/material.dart';
class ListMenu{
const ListMenu({this.judul, this.lambang, this.tampilan});
  final String judul;
  final Icon lambang;
  final String tampilan;
}
class MyMenuItem {
  MyMenuItem({this.judul, this.lambang, this.itemid, this.warna, this.route});
  final String judul;
  final IconData lambang;
  final String itemid;
  Color warna;
  final String route;
}
class MenuItem {
  const MenuItem({this.judul, this.lambang, this.tampilan});
  final String judul;
  final IconData lambang;
  final String tampilan;
}
class ListItem {
  const ListItem(
      {this.judul, this.lambang, this.urut, this.ndata = "0"});
  final String judul;
  final IconData lambang;
  final String urut;
  final String ndata;
}

class ListItemDDL {
  const ListItemDDL(
      {this.textDDL, this.valueDDL});
  final String textDDL;
  final String valueDDL;
  
}