import 'package:flutter/material.dart';

class RoundedLine extends StatelessWidget {
  const RoundedLine({
    Key? key,
    this.thikness = 1,
    this.width = 20,
    this.color = Colors.white,
  }) : super(key: key);
  final double width, thikness;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(thikness * 100)),
      height: thikness,
      constraints: BoxConstraints(maxHeight: thikness),
      width: width,
    );
  }
}
