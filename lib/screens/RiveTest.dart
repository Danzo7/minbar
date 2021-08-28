import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveTest extends StatelessWidget {
  const RiveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RiveAnimation.network(
        'https://cdn.rive.app/animations/vehicles.riv',
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
