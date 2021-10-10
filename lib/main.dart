import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minbar_fl/components/screens/profile/profile_screen.dart';
import 'package:minbar_fl/components/screens/General/general_screen.dart';
import 'package:minbar_fl/components/screens/home/home_screen.dart';
import 'package:minbar_fl/components/static/default_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'components/screens/login/login_screen.dart';
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

  //FlareCache.doesPrune = false;const [Color(0xff071A16), Color(0xff165173)]
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        routes: {
          '/home': (_) => HomeScreen(),
          '/login': (_) => LoginScreen(),
          "/showcase": (_) => GeneralScreen(),
          "/profile": (_) => ProfileScreen(),
        },
        home: ProfileScreen(),
      ),
    );
  }
}
