import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'package:minbar_fl/components/screens/screens.dart';

/// A [Navigator] observer that is used to notify [RouteAware]s of changes to
/// the state of their [Route].
final minbarRouteObserver = RouteObserver<ModalRoute<dynamic>>();

/// The [MinbarNavigator] contains the [Navigator] key used by the root
/// [MaterialApp].
///
/// This allows for navigation without access to the [BuildContext].
class MinbarNavigator {
  final GlobalKey<PageNavigationState> pageKey =
      GlobalKey<PageNavigationState>();

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

  Future navigateTo<TO extends Object?>(int index) {
    throwIf(
        pageKey.currentState == null, Exception('no PageNavigation found!'));
    return pageKey.currentState!.navigateTo(index);
  }

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

  Future pushToParameterScreen(String route,
          {Map<String, dynamic>? arguments, required SettingArgs options}) =>
      state.pushNamed<void>(
        route,
        arguments: <String, dynamic>{...?arguments, "options": options},
      );
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
  final settingParams = arguments['options'] as SettingArgs?;
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
    case GeneratedSettingsScreen.route:
      screen = settingParams != null
          ? GeneratedSettingsScreen(arguments: settingParams)
          : MasterScreen();
      break;
    default:
      //TODO? need a 404 callback
      throw ('route does not exist');
  }
  return PageRouteBuilder(
    settings: RouteSettings(name: routeName, arguments: arguments),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
