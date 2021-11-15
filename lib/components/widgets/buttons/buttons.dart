import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

typedef Void = void Function();

class Button extends StatelessWidget {
  final Void? onTap;
  final Color color;
  final double raduis;
  final double? height;
  final double? width;
  final Widget text;
  final Color? borderColor;

  Button(
    this.text, {
    this.onTap,
    this.color = DColors.green,
    this.height,
    this.width,
    this.raduis = 55,
    this.borderColor,
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
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(raduis),
                      side: borderColor != null
                          ? BorderSide(color: borderColor ?? color)
                          : BorderSide.none))),
          child: text,
          onPressed: onTap,
        ),
      ),
    );
  }
}

class ContentButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? height, width;
  final double raduis;
  final double spacing;
  final GestureTapCallback? onTap;

  const ContentButton(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.highlightColor,
      this.splashColor,
      this.height,
      this.width,
      this.raduis = 0,
      this.onTap,
      this.borderColor,
      this.spacing = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        color: backgroundColor,
        elevation: 0,
        borderRadius: BorderRadius.circular(raduis),
        shadowColor: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          highlightColor: highlightColor,
          borderRadius: BorderRadius.circular(raduis),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: spacing),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(raduis),
                border: borderColor != null
                    ? Border.all(color: borderColor ?? Colors.white)
                    : null),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ContentButtonV2 extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? height, width;
  final double raduis;
  final double spacing;
  final GestureTapCallback? onTap;

  const ContentButtonV2(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.highlightColor,
      this.splashColor,
      this.height,
      this.width,
      this.raduis = 0,
      this.onTap,
      this.borderColor,
      this.spacing = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FittedBox(
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(raduis),
              side: borderColor != null
                  ? BorderSide(color: borderColor ?? DColors.white)
                  : BorderSide.none),
          constraints: BoxConstraints(),
          fillColor: backgroundColor,
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          onPressed: onTap,
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: UnconstrainedBox(
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class FlatIconButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double size;
  final Widget icon;
  final double? iconSize;
  final GestureTapCallback? onTap;
  const FlatIconButton(
      {Key? key,
      this.backgroundColor,
      this.onTap,
      this.highlightColor,
      this.splashColor,
      this.size = 70,
      required this.icon,
      this.iconSize = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: RawMaterialButton(
        fillColor: backgroundColor,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: onTap,
        clipBehavior: Clip.none,
        child: Container(
          height: iconSize,
          width: iconSize,
          child: icon,
        ),
        shape: const CircleBorder(),
      ),
    );
  }
}

class NotAButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height, width;
  final double raduis;
  final double spacing;

  const NotAButton(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.height,
      this.width,
      this.raduis = 0,
      this.borderColor,
      this.spacing = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: spacing),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(color: borderColor ?? Colors.white)
              : null,
          borderRadius: BorderRadius.circular(raduis)),
      child: child,
    );
  }
}

class WuildButt extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? height, width;
  final double raduis;
  final double spacing;
  final GestureTapCallback? onTap;

  const WuildButt(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.highlightColor,
      this.splashColor,
      this.height,
      this.width,
      this.raduis = 0,
      this.onTap,
      this.borderColor,
      this.spacing = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: spacing),
      decoration: BoxDecoration(
          border: borderColor != null
              ? Border.all(color: borderColor ?? Colors.white)
              : null),
      child: child,
    );
  }
}
