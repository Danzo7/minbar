import 'package:flutter/material.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'package:minbar_fl/components/screens/parameters_screen/parameters_screen.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/model/setting_data_presentation.dart';

/// A [Navigator] observer that is used to notify [RouteAware]s of changes to
/// the state of their [Route].
final minbarRouteObserver = RouteObserver<ModalRoute<dynamic>>();

/// The [MinbarNavigator] contains the [Navigator] key used by the root
/// [MaterialApp].
///
/// This allows for navigation without access to the [BuildContext].
class MinbarNavigator {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  NavigatorState get state => key.currentState!;
  void pop<T extends Object>([T? result]) => state.pop<T>(result);

  Future<bool> maybePop<T extends Object>([T? result]) =>
      state.maybePop(result);

  Future<T?> push<T>(Route<T> route) => state.push<T>(route);

  void pushReplacementNamed(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    state.pushReplacementNamed<void, void>(
      route,
      arguments: <String, dynamic>{
        ...?arguments,
      },
    );
  }

  Future navigateTo<TO extends Object?>(BuildContext context, int index) =>
      Pager.navigateTo(context, index);

  void pushNamed(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    state.pushNamed<void>(
      route,
      arguments: <String, dynamic>{
        ...?arguments,
      },
    );
  }
}

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
