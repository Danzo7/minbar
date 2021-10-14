import 'dart:math';

import 'package:flutter/material.dart';

class SliverHeaderContainer extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double maxHeight;
  final Widget child;

  SliverHeaderContainer({
    required this.child,
    this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight ?? maxHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight ?? maxHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverHeaderContainer oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
