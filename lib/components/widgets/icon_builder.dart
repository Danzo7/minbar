import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBuilder extends StatelessWidget {
  const IconBuilder(this.name,
      {Key? key,
      this.outlined = false,
      this.color,
      this.size,
      this.fit = BoxFit.fitWidth})
      : super(key: key);
  final String name;
  final bool outlined;
  final Color? color;
  final double? size;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$name${outlined ? "_outlined" : ""}.svg",
      color: color,
      width: size,
      height: size,
      fit: fit,
    );
  }
}
