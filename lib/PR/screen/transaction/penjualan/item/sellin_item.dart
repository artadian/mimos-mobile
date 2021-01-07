import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/box_text_item.dart';
import 'package:mimos/helper/extension.dart';

class SellinItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int pac;
  final int slof;
  final int bal;
  final int introdeal;
  final String price;
  final Function onTap;
  final Function onDelete;

  SellinItem({
    this.title,
    this.subtitle,
    this.pac = 0,
    this.slof = 0,
    this.bal = 0,
    this.introdeal = 0,
    this.price,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
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
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  )
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
                        fontSize: 16,
                        color: Colors.orange),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
