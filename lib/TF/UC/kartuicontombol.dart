import 'package:flutter/material.dart';

class KartuIconTombol extends StatelessWidget {
  
  final IconData lambang;
  final String judul;
  final String urut;
  final String ndata;
  KartuIconTombol({this.judul="",this.lambang,this.ndata="",this.urut=""});

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
                  lambang,
                  color: Colors.blueAccent,
                  size: 54,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(judul),
                  Text(ndata),
                ],
              ),
            ],
          ),
          Icon(Icons.list),
        //  IconButton(
        //     icon: new Icon(Icons.list),
        //     onPressed: () {},
        //   ),
              // RaisedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.list),
              //   label: Text("View"),
              //   color: Colors.white,
              // ),
           
        ],
      ),
    );
  }
}
