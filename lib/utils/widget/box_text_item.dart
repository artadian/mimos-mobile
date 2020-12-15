import 'package:flutter/material.dart';

class BoxTextItem extends StatelessWidget {
  final String title;
  final int value;

  BoxTextItem({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 80),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              value.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: this.value != 0 ? Colors.grey[900] : Colors.grey[700]),
            ),
          ),
          Text(
            title ?? "-",
            style: TextStyle(
                color: this.value != 0 ? Colors.blue : Colors.grey[700]),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1.0)),
    );
  }
}