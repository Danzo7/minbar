import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TextPlay extends StatelessWidget {
  final Marquee marquee;
  final double minFontSize;
  final double? heightOffset;
  final TextAlign? textAlign;

  TextPlay({
    Key? key,
    required this.marquee,
    this.minFontSize = 8,
    this.heightOffset,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (2 * (marquee.style?.fontSize ?? 12) -
              (heightOffset ?? (marquee.style?.fontSize ?? 12) * 0.1)) *
          MediaQuery.of(context).textScaleFactor,
      child: AutoSizeText(
        marquee.text,
        minFontSize: minFontSize,
        maxFontSize: marquee.style?.fontSize ?? 12,
        style: marquee.style,
        textAlign: textAlign,
        maxLines: 1,
        overflowReplacement: marquee,
      ),
    );
  }
}
