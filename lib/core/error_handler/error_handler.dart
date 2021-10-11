import 'package:flutter/cupertino.dart';

import '../foundation/constants.dart';

class ErrorHandler {
  ErrorHandler(Widget app) {
    if (!hasHandleErrorFunctionality) runApp(app);
  }
}
