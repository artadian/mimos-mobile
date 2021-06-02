import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/box_text_item.dart';

class DisplayItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int pac;
  final bool withDelete;
  final Function onTap;
  final Function onDelete;

  DisplayItem({
    this.title,
    this.subtitle,
    this.pac = 0,
    this.withDelete = true,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        elevation: 3,
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
                        title ?? "-",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1, bottom: 3),
                        child: Text(subtitle ?? "-"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BoxTextItem(
                            title: "PAC",
                            value: pac,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                withDelete
                    ? IconButton(
                        onPressed: onDelete,
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          Icons.edit,
                          color: pac != 0 ? Colors.green : Colors.red,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
