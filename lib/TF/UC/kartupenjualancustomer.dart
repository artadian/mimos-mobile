import 'package:flutter/material.dart';

class KartuPenjualanCustomer extends StatelessWidget {
  final IconData logo;
  final Color warnalogo;
  final String namacustomer;
  final String kodecustomer;
  final String alamatcustomer;
  final String kotacustomer;
  final String tglkunjungan;
  final IconButton lambangaksi;
  final String datanota;
  final String penjualan;
  KartuPenjualanCustomer(
      {this.namacustomer = "",
      this.logo,
      this.warnalogo,
      this.kodecustomer = "",
      this.alamatcustomer = "",
      this.lambangaksi,
      this.kotacustomer = "",
      this.tglkunjungan = "",
      this.datanota = "",
      this.penjualan = ""});
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
                      color: warnalogo,
                      size: 45,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        namacustomer,
                        style: new TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(kodecustomer),
                      Text(alamatcustomer),
                      Text(kotacustomer),
                      Text(tglkunjungan),
                      Text(datanota),
                      Text(penjualan),
                    ],
                  ),
                ],
              ),
              lambangaksi,
            ]));
  }
}
