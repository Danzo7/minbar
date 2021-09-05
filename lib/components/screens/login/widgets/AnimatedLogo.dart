import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  AnimatedLogo({Key? key}) : super(key: key);

  @override
  _AnimatedLogoState createState() {
    return _AnimatedLogoState();
  }
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  String _animation = "logo";
  void setTimeLine(String animation) {
    setState(() {
      _animation = animation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 240,
        child: new FlareActor(
          "assets/flare/logo.flr",
          alignment: Alignment.topCenter,
          fit: BoxFit.scaleDown,
          animation: _animation,
        ));
  }
}
