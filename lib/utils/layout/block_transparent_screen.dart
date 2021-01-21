import 'package:flutter/material.dart';

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
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }
}
