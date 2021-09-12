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
  broadcast,
  listening
}

class DIcons {
  static Widget getIcon(IconList name,
          {bool filled = false, color = DColors.white}) =>
      SvgPicture.asset(
        "assets/icons/${name.toString().replaceAll(new RegExp("IconList."), "")}${filled ? "-filled" : ""}.svg",
        color: color,
        fit: BoxFit.fitWidth,
      );
}
