import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  ErrorScreen({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red.withOpacity(0.3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                message ?? "Error, terjadi kesalahan!!",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
