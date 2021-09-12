import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';

typedef Void = void Function();

class Button extends StatelessWidget {
  final Void? onClick;
  final String value;
  final Color color;
  Button({this.onClick, this.value = "text", this.color = DColors.green});
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        //  width: MediaQuery.of(context).size.width * 0.85,
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(DColors.white),
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55.0),
                      side: BorderSide(color: color)))),
          child: Text(
            value,
            style: TextStyle(fontSize: 12),
          ),
          onPressed: onClick,
        ),
      ),
    );
  }
}

class FlatIconButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double size;

  final GestureTapCallback? onTap;
  const FlatIconButton(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.onTap,
      this.highlightColor,
      this.splashColor,
      this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          highlightColor: highlightColor,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(size),
            child: child,
          ),
        ),
      ),
    );
  }
}
