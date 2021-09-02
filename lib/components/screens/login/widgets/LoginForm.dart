import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/formFields/inputBox.dart';

class LoginForm extends StatelessWidget {
  final Function? callback;
  const LoginForm({Key? key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(28),
      padding: EdgeInsets.only(bottom: 70),
      height: MediaQuery.of(context).size.height * 0.58,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Container(
                  child: InputBox(
                label: "البريد الالكتروني",
                type: boxType.text,
                iconPath: "assets/icons/email.svg",
              )),
              Container(
                  child: InputBox(
                label: "كلمة المرور",
              ))
            ]),
            Button(value: 'تسجيل الدخول', onClick: () => callback!("Typing")),
            Button(
              value: 'انشاء حساب',
              onClick: () => callback!("movie"),
              color: DColors.orange,
            ),
            InkWell(
                child: Icon(
              Icons.arrow_back,
              color: DColors.white,
            )),
          ]),
    );
  }
}
