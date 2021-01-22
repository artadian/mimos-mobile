import 'package:flutter/material.dart';

class SpanText extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final double radius;

  SpanText(
    this.text, {
    this.padding,
    this.color,
    this.size,
    this.fontWeight,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: size ?? 12,
            fontWeight: fontWeight ?? FontWeight.normal),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: color ?? Colors.grey[700]),
    );
  }
}
