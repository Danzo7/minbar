import 'package:flutter/material.dart';
import 'package:minbar_fl/static/colors.dart';
import 'package:minbar_fl/widgets/buttons.dart';

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
          appBar: AppBar(title: Text("Minbar")),
          body: Center(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Text("data 1"),
                  Text("data 2"),
                  Button(
                      value: 'تسجيل الدخول',
                      onClick: () => setState(() => {count++})),
                  SizedBox(height: 10),
                  Button(
                    value: 'انشاء حساب',
                    onClick: () => setState(() => {count++}),
                    color: DColors.orange,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                ])),
          )),
    );
  }
}
