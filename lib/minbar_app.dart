import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'core/services/service_locator.dart';

class MinbarApp extends StatelessWidget {
  const MinbarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      // Configure default bottom indicator
      headerTriggerDistance: 50.0, footerTriggerDistance: 1,
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 100,
      child: MaterialApp(
        //showPerformanceOverlay: true,
        theme: ThemeData(
            fontFamily: 'Cairo',
            textTheme: const TextTheme(
                headline1: TextStyle(fontWeight: FontWeight.w200),
                headline6: TextStyle(fontWeight: FontWeight.w200),
                bodyText2: TextStyle(fontWeight: FontWeight.w200),
                button: TextStyle(fontWeight: FontWeight.w200))),
        color: DColors.white,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"),
          Locale('ar', 'AE') // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale('ar', 'AE'),
        navigatorObservers: [
          minbarRouteObserver,
        ],
        navigatorKey: app<MinbarNavigator>().key,

        onGenerateRoute: onGenerateRoute,
        home: MasterScreen(),
      ),
    );
  }
}
