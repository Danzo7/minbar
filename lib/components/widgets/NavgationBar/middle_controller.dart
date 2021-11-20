import 'package:flutter/material.dart';

enum MiddleMode { normal, outside, inside }

class MiddleController extends ValueNotifier<MiddleMode> {
  MiddleController() : super(MiddleMode.normal);
  MiddleMode get mode => value;
  set mode(x) => value = x;

  bool get isNormal => value == MiddleMode.normal;
  bool get isOut => value == MiddleMode.outside;
  bool get isIn => value == MiddleMode.inside;
  void outside() => value = MiddleMode.outside;
  void normal() => value = MiddleMode.normal;
  void inside() => mode = MiddleMode.inside;
}
