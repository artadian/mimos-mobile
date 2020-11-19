import 'package:flutter/material.dart';

class KartuStockTF extends StatelessWidget {
  final IconButton lambangaksikiri;
  final String namamaterial;
  final String kodematerial;
  final String trxid;
  final String qtypac;
  final String qtyslof;
  final String qtybal;
  final IconButton lambangaksikanan;
  KartuStockTF(
      {this.lambangaksikiri,
      this.namamaterial = "",
      this.kodematerial = "",
      this.trxid = "",
      this.qtypac = "",
      this.qtyslof = "",
      this.qtybal = "",
      this.lambangaksikanan});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                 // Container(margin: EdgeInsets.all(5), child: lambangaksikiri),
                  lambangaksikiri,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        namamaterial,
                        style: new TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(kodematerial),
                      Text(qtypac),
                      Text(qtyslof),
                      //Text(qtybal),
                      //Text(trxid),
                    ],
                  ),
                ],
              ),
              lambangaksikanan
              //Container(margin: EdgeInsets.all(5), child: lambangaksikanan),
            ]));
  }
}
