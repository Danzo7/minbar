import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/soda_icons_icons.dart';
import 'package:minbar_fl/components/static/textStyles.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/formFields/inputBox.dart';

class LoginForm extends StatelessWidget {
  final Function? callback;
  const LoginForm({Key? key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(28),
      //padding: EdgeInsets.only(bottom: 70),
      height: MediaQuery.of(context).size.height * 0.58,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              InputBox(
                label: "البريد الالكتروني",
                type: boxType.text,
                icon: SodaIcons.email,
              ),
              InputBox(
                label: "كلمة المرور",
              )
            ]),
            Button(
              Text(
                'تسجيل الدخول',
                style: DTextStyle.w12,
              ),
              width: double.infinity,
              height: 50,
            ),
            Button(
              Text(
                'انشاء حساب',
                style: DTextStyle.w12,
              ),
              color: DColors.orange,
              width: double.infinity,
              height: 50,
            ),
            FlatIconButton(
                size: 40,
                backgroundColor: Colors.transparent,
                onTap: () => {Navigator.pushReplacementNamed(context, '/home')},
                icon: Icon(
                  Icons.arrow_back,
                  color: DColors.white,
                )),
          ]),
    );
  }
}
