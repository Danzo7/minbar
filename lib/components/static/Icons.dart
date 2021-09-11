import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minbar_fl/components/static/colors.dart';

enum IconList {
  home,
  article,
  profile,
  settings,
  email,
  hide,
  unhide,
}

class DIcons {
  static Widget getIcon(IconList name,
          {bool filled = false, color = DColors.white}) =>
      SvgPicture.asset(
        "assets/icons/${name.toString().replaceAll(new RegExp("IconList."), "")}${filled ? "-filled" : ""}.svg",
        color: color,
        fit: BoxFit.fitWidth,
      );

  static Widget generateSvgIcons(path,
      {color = Colors.white, width = 20, heigt = 20}) {
    return Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        child: SvgPicture.asset(
          path,
          color: Colors.amberAccent,
          fit: BoxFit.fitWidth,
        ));
  }
}
