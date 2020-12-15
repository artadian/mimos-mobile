import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final Widget child;
  final Widget childBottom;
  final Function onPressed;
  final double paddingText;
  final double elevation;
  final double padding;
  final double borderRadius;

  ButtonCard({
    Key key,
    this.child,
    this.childBottom,
    this.onPressed,
    this.elevation,
    this.paddingText,
    this.padding,
    this.borderRadius,
  })  : assert(child != null),
        super(
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(padding ?? 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              child,
              SizedBox(
                height: paddingText ?? 0.0,
              ),
              childBottom
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
          ),
        ),
      ),
    );
  }
}
