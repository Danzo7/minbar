import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';

typedef Void = void Function();

class Button extends StatelessWidget {
  final Void? onClick;
  final Color color;
  final double raduis;
  final double? height;
  final double? width;
  final Widget text;
  Button(
    this.text, {
    this.onClick,
    this.color = DColors.green,
    this.height,
    this.width,
    this.raduis = 55,
  });
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: height,
        width: width,
        //  width: MediaQuery.of(context).size.width * 0.85,
        child: TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(DColors.white),
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(raduis),
                      side: BorderSide(color: color)))),
          child: text,
          onPressed: onClick,
        ),
      ),
    );
  }
}

class ContainButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? height, width;
  final double raduis;
  final GestureTapCallback? onTap;

  const ContainButton(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.highlightColor,
      this.splashColor,
      this.height,
      this.width,
      this.raduis = 0,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: backgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          highlightColor: highlightColor,
          onTap: onTap,
          child: child,
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
