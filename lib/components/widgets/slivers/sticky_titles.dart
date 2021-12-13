import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';

class StickyTitles extends StatelessWidget {
  final double? minHeight;
  final double maxHeight;
  final Color? shrinkedColor;
  final Color? backgroundColor;
  final String title;
  final TextStyle? shrinkTextStyle, textStyle;

  const StickyTitles(
      {Key? key,
      this.minHeight,
      required this.maxHeight,
      this.shrinkedColor,
      this.backgroundColor,
      required this.title,
      this.shrinkTextStyle,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: _SliverStickyTitles(
            minHeight: minHeight,
            maxHeight: maxHeight,
            shrinkedColor: shrinkedColor,
            backgroundColor: backgroundColor,
            title: title,
            textStyle: textStyle,
            shrinkTextStyle: shrinkTextStyle));
  }
}

class _SliverStickyTitles extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double maxHeight;

  final Color? shrinkedColor;
  final Color? backgroundColor;
  final String title;

  final TextStyle? shrinkTextStyle, textStyle;
  const _SliverStickyTitles({
    this.minHeight,
    required this.maxHeight,
    required this.title,
    this.shrinkedColor,
    this.backgroundColor,
    this.shrinkTextStyle,
    this.textStyle,
  });

  @override
  double get minExtent => minHeight ?? maxHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight ?? maxHeight);

  // 2
  @override
  Widget build(BuildContext context, _, bool overlapsContent) {
    return AnimatedContainer(
        color: overlapsContent
            ? shrinkedColor ?? backgroundColor
            : backgroundColor,
        duration: kFlashAnimationDuration,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(
            title,
            style: TextStyle()
                .merge(overlapsContent ? shrinkTextStyle : textStyle),
          ),
        ));
  }

  @override
  bool shouldRebuild(_SliverStickyTitles oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
