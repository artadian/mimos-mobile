import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  final Widget content;
  final Color backgroundTitle;
  final String title;
  final EdgeInsetsGeometry contentPadding;
  final List<Widget> actions;
  final EdgeInsetsGeometry insetPadding;
  final EdgeInsetsGeometry titlePadding;

  DefaultDialog({
    this.content,
    this.backgroundTitle,
    this.title,
    this.contentPadding,
    this.actions,
    this.insetPadding,
    this.titlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: contentPadding ?? EdgeInsets.all(24),
      actions: actions,
      insetPadding:
          insetPadding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      titlePadding: titlePadding ?? EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.fromLTRB(24, 2, 8, 2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "Title",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
        decoration: BoxDecoration(
          color: backgroundTitle ?? Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3)),
        ),
      ),
      content: content,
    );
    ;
  }
}
