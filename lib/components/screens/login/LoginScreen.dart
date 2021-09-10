import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/login/widgets/AnimatedLogo.dart';
import 'widgets/LoginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   image: const AssetImage('assets/images/bug.png'),
                    //   fit: BoxFit.fitHeight,
                    //   alignment: Alignment.topCenter,
                    // )),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff071A16), Color(0xff165173)],
                    )),
                    child: Stack(alignment: Alignment.topCenter, children: [
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: LoginForm()),
                      AnimatedLogo(),
                    ]))),
          )),
    );
  }
}
