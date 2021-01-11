import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/box_text_item.dart';

class PosmItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String qty;
  final String status;
  final String condition;
  final String notes;
  final Function onTap;
  final Function onDelete;

  PosmItem({
    this.title,
    this.subtitle,
    this.qty,
    this.status,
    this.condition,
    this.notes,
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1, bottom: 3),
                      child: Text(subtitle ?? ""),
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          child: Text(
                            status,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: status.toLowerCase() == "new"
                                  ? Colors.green
                                  : Colors.blue),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (condition != null && condition.isNotEmpty)
                          Text(
                            condition ?? "",
                            style: TextStyle(fontSize: 15),
                          ),
                      ],
                    ),
                    if (notes != null && notes.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                        child: Text(
                          notes ?? "",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                      )
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
        ),
      ),
    );
  }
}
