import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/span_text.dart';

class TrialItem extends StatelessWidget {
  final String title;
  final Widget titleEnd;
  final String subtitle1;
  final String subtitle2Left;
  final String subtitle2Right;
  final String footer1;
  final String footer2;
  final String footer3;
  final double elevation;
  final Widget trailing;
  final Function onTap;

  TrialItem({
    this.title,
    this.titleEnd,
    this.subtitle1,
    this.subtitle2Left,
    this.subtitle2Right,
    this.footer1,
    this.footer2,
    this.footer3,
    this.elevation,
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
                children: [
                  Expanded(
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  titleEnd ?? SizedBox(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(subtitle1 ?? "")),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: subtitle2Left ?? "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  )),
                              TextSpan(
                                  text: " ${subtitle2Right ?? ""}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  trailing ?? SizedBox()
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
