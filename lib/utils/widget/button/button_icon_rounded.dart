import 'package:flutter/material.dart';

class ButtonIconRounded extends StatelessWidget {
  final double elevation;
  final Function onPressed;
  final String text;
  final IconData icon;
  final EdgeInsets padding;
  final double radius;
  final Color color;

  ButtonIconRounded({
    this.elevation,
    this.onPressed,
    this.text,
    this.icon,
    this.padding,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation ?? 6,
      padding: padding ?? EdgeInsets.fromLTRB(16, 10, 22, 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 50)),
      color: color ?? Colors.blue,
      disabledColor: Colors.grey,
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon ?? Icons.add_circle_outline,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text ?? "Add",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
