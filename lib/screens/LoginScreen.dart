import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minbar_fl/screens/RiveTest.dart';
import 'package:minbar_fl/static/colors.dart';
import 'package:minbar_fl/widgets/buttons.dart';
import 'package:minbar_fl/widgets/inputBox.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int count = 215;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Container(
              child: Stack(children: [
        Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            child: RiveTest()),
        Container(
            margin: EdgeInsets.all(28),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'نهاية العالم بعد $count عام',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                      child: InputBox(
                    label: "الاسم",
                  )),
                  Button(
                      value: 'تسجيل الدخول',
                      onClick: () => setState(() => {count++})),
                  SizedBox(height: 10),
                  Button(
                    value: 'انشاء حساب',
                    onClick: () => setState(() => {count--}),
                    color: DColors.orange,
                  ),
                ])),
      ]))),
    );
  }
}
