import 'package:flutter/material.dart';
import 'components/screens/login/LoginScreen.dart';
import 'components/static/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: LoginScreen(),
      ),
      color: DColors.green,
    );
  }
}
