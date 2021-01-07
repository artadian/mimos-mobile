import 'package:flutter/material.dart';

class ReportBoxItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  ReportBoxItem({
    this.title,
    this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              title ?? "-",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(color: color ?? Colors.blue),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              value ?? "0",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
