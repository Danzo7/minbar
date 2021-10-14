import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/parameters_screen/parameters_screen.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';

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
    case ProfilePage.route:
      screen = ProfilePage();
      break;
    case HomePage.route:
      screen = HomePage();
      break;
    case BroadcastsPage.route:
      screen = BroadcastsPage();
      break;
    case SettingsScreen.route:
      screen = SettingsScreen();
      break;
    case ParametersScreen.route:
      screen = settingParams != null
          ? ParametersScreen(arguments: settingParams)
          : MasterScreen();
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
