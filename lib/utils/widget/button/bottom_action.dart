import 'package:flutter/material.dart';

class BottomAction extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final EdgeInsets padding;
  final double height;
  final Function onPressed;

  BottomAction(
      {this.text,
        this.color,
        this.textColor,
        this.padding,
        this.height,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      child: MaterialButton(
        height: height ?? 45,
        onPressed: onPressed,
        child: Text(
          text ?? "Simpan",
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 16),
        ),
        color: color ?? Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
