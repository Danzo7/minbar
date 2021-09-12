import 'package:flutter/cupertino.dart';

class Helpers {
  static Widget rtl(Widget widget) =>
      Directionality(textDirection: TextDirection.rtl, child: widget);
  static Widget ltr(Widget widget) =>
      Directionality(textDirection: TextDirection.ltr, child: widget);
}
