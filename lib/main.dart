import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minbar_fl/components/screens/ShowCaseScreen.dart';
import 'package:minbar_fl/components/screens/home/homeScreen.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'components/screens/login/LoginScreen.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  GestureBinding.instance?.resamplingEnabled = true; // Set this flag.
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  //FlareCache.doesPrune = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        "/showcase": (_) => ShowCaseScreen(),
      },
      home: HomeScreen(),
    );
  }
}
