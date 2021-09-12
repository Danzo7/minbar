import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minbar_fl/components/screens/home/homeScreen.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'components/screens/login/LoginScreen.dart';

void main() {
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
        'HomeScreen': (_) => HomeScreen(),
        'LoginScreen': (_) => LoginScreen()
      },
      initialRoute: 'LoginScreen',
      home: LoginScreen(),
    );
  }
}
