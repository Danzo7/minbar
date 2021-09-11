import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minbar_fl/components/static/colors.dart';

class AnimatedLogo extends StatefulWidget {
  AnimatedLogo({Key? key}) : super(key: key);

  @override
  _AnimatedLogoState createState() {
    return _AnimatedLogoState();
  }
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  int step = 0;
  void _nextStep() {
    setState(() {
      step++;
    });
  }

  @override
  void initState() {
    print("gh");
    _warmupAnimations().then((value) => _nextStep());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(step);

    return step == 0
        ? Image.asset(
            'assets/images/typeLogo.png',
            alignment: Alignment.topCenter,
          )
        : RepaintBoundary(
            child: step == 1
                ? Container(
                    width: 300,
                    height: 240,
                    child: FlareActor(
                      "assets/flare/logo.flr",
                      alignment: Alignment.topCenter,
                      fit: BoxFit.scaleDown,
                      animation: "Typing",
                      callback: (animationName) {
                        print("typing");

                        _nextStep();
                      },
                    ))
                : Container(
                    width: 300,
                    height: 240,
                    child: FlareActor(
                      "assets/flare/logo.flr",
                      alignment: Alignment.topCenter,
                      fit: BoxFit.scaleDown,
                      animation: "movie",
                    )));
  }

  Future<void> _warmupAnimations() async {
    await cachedActor(
        AssetFlare(bundle: rootBundle, name: 'assets/flare/logo.flr'));
  }
}
