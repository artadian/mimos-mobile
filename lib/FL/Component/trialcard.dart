import 'package:flutter/material.dart';

class TrialCard extends StatelessWidget {
  final String location;
  final String name;
  final String material;
  final String qty;
  final String totalamount;
  TrialCard(
      {this.location = "",
      this.name = "",
      this.material = "",
      this.qty = "",
      this.totalamount = ""});
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
