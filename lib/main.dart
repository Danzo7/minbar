import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/loading/LoadingScreen.dart';
import 'components/screens/login/LoginScreen.dart';

void main() {
  FlareCache.doesPrune = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      routes: {
        'LoadingScreen': (_) => LoadingScreen(),
        'LoginScreen': (_) => LoginScreen()
      },
      initialRoute: 'LoadingScreen',
      home: LoginScreen(),
    );
  }
}
