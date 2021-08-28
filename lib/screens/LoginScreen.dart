import 'package:flutter/material.dart';
import 'package:minbar_fl/static/colors.dart';
import 'package:minbar_fl/widgets/buttons.dart';
import 'package:minbar_fl/widgets/inputBox.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Center(
        child: Container(
            margin: EdgeInsets.all(28),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "الجزائر $count الى الهاية",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
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
      )),
    );
  }
}
