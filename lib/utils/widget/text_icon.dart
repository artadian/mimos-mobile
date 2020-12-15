import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double fontSize;
  final double iconSize;
  final FontWeight fontWeight;
  final double iconPadding;
  final double paddingNext;

  TextIcon({
    this.text,
    this.icon,
    this.color,
    this.iconColor,
    this.fontSize,
    this.iconSize,
    this.fontWeight,
    this.iconPadding,
    this.paddingNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: paddingNext ?? 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: iconPadding ?? 8),
            child: Icon(
              icon ?? Icons.album,
              color: iconColor ?? Colors.grey,
              size: iconSize ?? 20,
            ),
          ),
          Expanded(
            child: Text(
              text ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
