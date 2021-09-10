import 'package:flutter/material.dart';
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
      theme: ThemeData(fontFamily: 'Cairo'),
      color: DColors.white,
      // routes: {
      //   'LoadingScreen': (_) => LoadingScreen(),
      //   'LoginScreen': (_) => LoginScreen()
      // },
      // initialRoute: 'LoginScreen',
      home: LoginScreen(),
    );
  }
}
