import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
