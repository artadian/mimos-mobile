import 'package:flutter/material.dart';
class KartuCustomer extends StatelessWidget {
  final Icon logo;
  final String namacustomer;
  final String kodecustomer;
  final String alamatcustomer;
  final String kotacustomer;
  final String tglkunjungan;
  final IconButton lambangaksi;
  KartuCustomer({this.namacustomer="",this.logo,this.kodecustomer="",this.alamatcustomer="",this.lambangaksi,this.kotacustomer="",this.tglkunjungan=""});
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
                // child: Icon(
                //   logo,
                //   color: Colors.blueAccent,
                //   size: 45,
                // ),
                child: logo,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(namacustomer,style: new TextStyle(fontSize:15,fontWeight: FontWeight.bold),),
                  Text(kodecustomer),
                  Text(alamatcustomer),
                  Text(kotacustomer),
                  Text(tglkunjungan),
                ],
              ),
            ],
          ),
          lambangaksi, 
        ]
      )
    );
  }
}