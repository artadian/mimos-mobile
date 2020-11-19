import 'package:flutter/material.dart';

class CustomerProgressBar extends StatelessWidget {
  final double width;
  CustomerProgressBar({this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children :<Widget>[
            Container(),
            Container()
          ]
        )
      ],
    );
  }
}