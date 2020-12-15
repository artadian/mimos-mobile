import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;

  EmptyScreen({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.live_help,
              size: 100,
              color: Colors.blue.withOpacity(0.3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                message ?? "Data tidak ditemukan!!",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
