import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'widgets/LoginForm.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _animation = "logo";

  @override
  Widget build(BuildContext context) {
    void _animate(String animation) {
      setState(() {
        _animation = animation;
      });
    }

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: const AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  )),
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Container(
                        width: 300,
                        height: 240,
                        child: new FlareActor(
                          "assets/flare/logo.flr",
                          alignment: Alignment.topCenter,
                          fit: BoxFit.scaleDown,
                          animation: _animation,
                        )),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: LoginForm(callback: _animate))
                  ]))),
        ));
  }
}
