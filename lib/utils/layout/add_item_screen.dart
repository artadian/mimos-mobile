import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  final String message;
  final Function onTap;

  AddItemScreen({this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 100,
                color: Colors.blue.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  message ?? "Click to Add item",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
