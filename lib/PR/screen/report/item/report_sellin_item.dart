import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/box_text_item.dart';
import 'package:mimos/helper/extension.dart';

class ReportSellinItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int pac;
  final int slof;
  final int bal;
  final int introdeal;
  final String price;
  final Function onTap;
  final Function onDelete;
  final String totalPrice;
  final double elevation;

  ReportSellinItem({
    this.title,
    this.subtitle,
    this.pac = 0,
    this.slof = 0,
    this.bal = 0,
    this.introdeal = 0,
    this.price,
    this.onTap,
    this.onDelete,
    this.totalPrice,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1, bottom: 3),
                          child: Text(subtitle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BoxTextItem(
                              title: "PAC",
                              value: pac,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: BoxTextItem(
                                title: "SLOF",
                                value: slof,
                              ),
                            ),
                            BoxTextItem(
                              title: "BAL",
                              value: bal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoxTextItem(
                    title: "INTRODEAL",
                    value: introdeal,
                  ),
                  Text(
                    price != null ? "@ Rp. ${price.toMoney()} / Pac" : "-",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.orange),
                  ),
                ],
              ),
              Container(
                height: 0.5,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 5),
              ),
              Text(
                totalPrice != null ? "Total: Rp. ${totalPrice.toMoney()}" : "-",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
