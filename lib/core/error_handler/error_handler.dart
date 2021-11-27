import 'package:flutter/cupertino.dart';
import 'package:minbar_fl/core/foundation/constants.dart';

class ErrorHandler {
  ErrorHandler(Widget app) {
    if (!hasHandleErrorFunctionality) runApp(app);
  }
}
