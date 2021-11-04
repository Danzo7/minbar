import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StickyTitles extends StatelessWidget {
  final double? minHeight;
  final double maxHeight;
  final bool shrink;
  final Color? shrinkedColor;
  final Color? backgroundColor;
  final Widget title;

  final bool hasPopularity;
  const StickyTitles(
      {Key? key,
      this.minHeight,
      required this.maxHeight,
      this.shrink = true,
      this.hasPopularity = true,
      this.shrinkedColor,
      this.backgroundColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: _SliverStickyTitles(
          minHeight: minHeight,
          maxHeight: maxHeight,
          shrink: shrink,
          hasPopularity: hasPopularity,
          shrinkedColor: shrinkedColor,
          backgroundColor: backgroundColor,
          title: title,
        ));
  }
}

class _SliverStickyTitles extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double maxHeight;

  final bool shrink;
  final Color? shrinkedColor;
  final Color? backgroundColor;
  final Widget title;

  final bool hasPopularity;
  _SliverStickyTitles(
      {this.minHeight,
      required this.maxHeight,
      required this.shrink,
      required this.hasPopularity,
      this.shrinkedColor,
      this.backgroundColor,
      required this.title});

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
        duration: Duration(milliseconds: 10),
        child: title);
  }

  @override
  bool shouldRebuild(_SliverStickyTitles oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
