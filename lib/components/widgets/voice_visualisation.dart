import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';

import 'rounder_line.dart';

class VoiceVisualisation extends StatefulWidget {
  const VoiceVisualisation({
    Key? key,
  }) : super(key: key);

  @override
  State<VoiceVisualisation> createState() => _VoiceVisualisationState();
}

class _VoiceVisualisationState extends State<VoiceVisualisation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: kLongAnimationDuration,
      debugLabel: 'MinbarbottomSheet',
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    controller.addListener(() => (setState(() {})));
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value == 0)
      controller.forward();
    else if (controller.value == 1) controller.reverse();

    double n1 = max(
        min(controller.value * Random().nextInt(30) + Random().nextInt(10), 40),
        5);
    double n2 = max(
        min(
            controller.value * Random().nextInt(n1.toInt()) +
                Random().nextInt(10),
            40),
        5);
    double n3 = max(
        min(
            controller.value * Random().nextInt(n2.toInt()) +
                Random().nextInt(10),
            40),
        5);
    double n4 = max(
        min(
            controller.value * Random().nextInt(n3.toInt()) +
                Random().nextInt(10),
            40),
        5);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: RoundedLine(
            thikness: n1,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: RoundedLine(
            thikness: n2,
            width: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: RoundedLine(
            thikness: n3,
            width: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: RoundedLine(
            thikness: n4,
            width: 3,
          ),
        ),
      ],
    );
  }
}
