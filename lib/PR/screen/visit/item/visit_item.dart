import 'package:flutter/material.dart';
import 'package:mimos/utils/widget/span_text.dart';

class VisitItem extends StatelessWidget {
  final int no;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String footer1;
  final String footer2;
  final String footer3;
  final double elevation;
  // final Widget leading;
  final Widget trailing;
  final Function onTap;
  final Color color;
  final String wsp;

  VisitItem({
    this.no,
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.footer1,
    this.footer2,
    this.footer3,
    this.elevation,
    // this.leading,
    this.trailing,
    this.onTap,
    this.color,
    this.wsp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 6,
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                left: BorderSide(color: color ?? Colors.grey[300], width: 8)),
          ),
          padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: Text(
                      no.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              color != null ? Colors.white : Colors.grey[900]),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: color ?? Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      // border: Border.all(color: Colors.grey, width: 1)
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 2, bottom: 2, left: 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    subtitle1 ?? "",
                                  ),
                                ),
                                SpanText(
                                  "WSP",
                                  color: wsp == "S"
                                      ? Color(0xFFB0B0B0)
                                      : wsp == "B"
                                      ? Colors.brown
                                      : wsp == "G"
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                                SizedBox(width: 5,),
                                Text("")
                              ],
                            ),
                          ),
                          Text(subtitle2 ?? "")
                        ],
                      ),
                    ),
                  ),
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
