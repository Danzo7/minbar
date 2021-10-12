import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/components/screens/settings/setting_data_presentation.dart';

/// [onGenerateRoute] is called whenever a new named route is being pushed to
/// the app.
///
/// The [RouteSettings.arguments] that can be passed along the named route
/// needs to be a `Map<String, dynamic>` and can be used to pass along
/// arguments for the screen.

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final routeName = settings.name;

  final arguments =
      settings.arguments as Map<String, dynamic>? ?? <String, dynamic>{};
  final settingParams = arguments['settingParams'] as List<Param>?;
  Widget screen;

  switch (routeName) {
    case ProfileScreen.route:
      screen = ProfileScreen();
      break;
    case HomeScreen.route:
      screen = HomeScreen();
      break;
    case GeneralScreen.route:
      screen = GeneralScreen();
      break;
    case SettingsScreen.route:
      screen = SettingsScreen();
      break;
    case SettingParamsScreen.route:
      screen = settingParams != null
          ? SettingParamsScreen(arguments: settingParams)
          : HomeScreen();
      break;
    default:
      print('route does not exist; navigating to login screen instead');
      screen = const LoginScreen();
  }
  return MaterialPageRoute<void>(
    builder: (_) => screen,
    settings: RouteSettings(name: routeName, arguments: arguments),
  );
}
