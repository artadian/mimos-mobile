import 'package:flutter/material.dart';

class ProductExtend extends StatelessWidget {
  final EdgeInsets padding;
  final String title;

  ProductExtend({this.padding, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: padding,
      child: Card(
        elevation: 6,
        child: ListTile(
          leading: Icon(Icons.shopping_basket, color: Colors.indigo,),
          title: Text(title ?? "-"),
        ),
      ),
    );
  }
}
