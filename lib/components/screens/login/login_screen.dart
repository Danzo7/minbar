import 'package:flutter/material.dart';
import 'widgets/flare_animated_logo.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String route = 'login';

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff071A16), Color(0xff165173)],
                  )),
                  child: Stack(alignment: Alignment.topCenter, children: [
                    AnimatedLogo(),
                    Container(
                        alignment: Alignment.bottomCenter, child: LoginForm()),
                  ]))),
        ));
  }
}
