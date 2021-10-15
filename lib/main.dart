import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/core/error_handler/error_handler.dart';
import 'core/services/service_locator.dart';
import 'minbar_app.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: DColors.blueGray,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  GestureBinding.instance?.resamplingEnabled = true; // Set this flag.
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  setupServices();
  ErrorHandler(MinbarApp());
}
