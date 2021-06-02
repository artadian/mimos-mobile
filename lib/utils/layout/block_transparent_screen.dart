import 'package:flutter/material.dart';
import 'dart:math' as math;

class BlockTransparentScreen extends StatelessWidget {
  final Function onTap;

  BlockTransparentScreen({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.1),
        child: Center(
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Text('COMPLETE', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amber.withOpacity(0.2),
              fontSize: 52
            ),),
          ),
        ),
      ),
    );
  }
}
