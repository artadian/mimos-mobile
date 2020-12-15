import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double size;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final Function onTap;

  CircleIcon(
    this.icon, {
    this.color,
    this.backgroundColor,
    this.size,
    this.padding,
    this.margin,
    this.borderColor,
    this.borderWidth,
    this.radius,
        this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding ?? EdgeInsets.all(8),
        child: Icon(
          icon,
          size: size ?? 26,
          color: color ?? Colors.white,
        ),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey,
            border: Border.all(
                color: borderColor ?? Colors.grey[700], width: borderWidth ?? 1),
            borderRadius: BorderRadius.circular(radius ?? 50)),
      ),
    );
  }
}
