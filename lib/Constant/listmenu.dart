import 'package:flutter/material.dart';
class ListMenu{
const ListMenu({this.judul, this.lambang, this.tampilan});
  final String judul;
  final Icon lambang;
  final String tampilan;
}
class MyMenuItem {
  const MyMenuItem({this.judul, this.lambang, this.itemid, this.warna});
  final String judul;
  final IconData lambang;
  final String itemid;
  final Color warna;
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