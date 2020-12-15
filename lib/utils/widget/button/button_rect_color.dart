import 'package:flutter/material.dart';

class ButtonRectColor extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final double radius;
  final Function onPressed;

  ButtonRectColor({
    this.color,
    this.title,
    this.icon,
    this.radius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              child: Icon(
                icon ?? Icons.home,
                color: color ?? Colors.blue,
              ),
              backgroundColor: Colors.white,
            ),
            Text(
              title ?? "",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}