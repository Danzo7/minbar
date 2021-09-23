import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBuilder extends StatelessWidget {
  const IconBuilder(this.name,
      {Key? key, this.fill = false, this.color, this.size})
      : super(key: key);
  final String name;
  final bool fill;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$name${fill ? "-filled" : ""}.svg",
      color: color,
      width: size,
      fit: BoxFit.fitWidth,
    );
  }
}
