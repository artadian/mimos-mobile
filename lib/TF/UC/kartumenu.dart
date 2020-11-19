import 'package:flutter/material.dart';
import 'package:mimos/Constant/Constant.dart';

class KartuMenu extends StatelessWidget {
  final IconData logo;
  final String judul;
  final String urut;
  final String ndata;
  final IconData lambangaksi;
  KartuMenu(
      {this.judul = "",
      this.logo,
      this.ndata = "",
      this.urut = "",
      this.lambangaksi});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Icon(
                  logo,
                  //color: Colors.blueAccent,
                  color: MyPalette.ijoMimos,
                  size: 54,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(judul),
                  Text(ndata),
                ],
              ),
            ],
          ),
          Icon(lambangaksi),
        ],
      ),
    );
  }
}
