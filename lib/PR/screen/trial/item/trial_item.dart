import 'package:flutter/material.dart';

class TrialItem extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String footer1;
  final String footer2;
  final String footer3;
  final double elevation;
  final Widget leading;
  final Widget trailing;
  final Function onTap;

  TrialItem({
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.footer1,
    this.footer2,
    this.footer3,
    this.elevation,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading ?? SizedBox(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(subtitle1 ?? "")),
                      Text(subtitle2 ?? "")
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.grey[400],
                  height: 1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5, top: 3),
                    child: Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: footer1 ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              )),
                          TextSpan(
                              text: " ${footer2 ?? ""}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                              text: " ${footer3 ?? ""}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
