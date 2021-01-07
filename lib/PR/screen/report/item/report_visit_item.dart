import 'package:flutter/material.dart';

class ReportVisitItem extends StatelessWidget {
  final String value;
  final String title;
  final Color color;

  ReportVisitItem({
    this.value,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              value ?? "0",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title ?? "-",
            style: TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}