import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';

class SliverHeaderCarousel extends StatelessWidget {
  final double? minHeight;
  final double maxHeight;
  final Widget? title;
  final Widget carousel;
  const SliverHeaderCarousel(
      {Key? key,
      this.minHeight,
      required this.maxHeight,
      required this.carousel,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: _SliverHeaderCarouselDelegate(
          child: carousel,
          minHeight: minHeight,
          maxHeight: maxHeight,
          title: title,
        ));
  }
}

class _SliverHeaderCarouselDelegate extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double maxHeight;
  final Widget child;
  final Widget? title;

  _SliverHeaderCarouselDelegate(
      {this.minHeight,
      required this.maxHeight,
      required this.child,
      this.title});

  @override
  double get minExtent => minHeight ?? maxHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight ?? maxHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage = min(1, shrinkOffset / (maxExtent - minExtent));
    return AnimatedOpacity(
        opacity: max(0, 1 - (shrinkPercentage) * 9),
        duration: kFlashAnimationDuration,
        child: Wrap(spacing: 10, children: [
          if (title != null)
            Container(
              child: title,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: child,
          ),
        ]));
  }

  @override
  bool shouldRebuild(_SliverHeaderCarouselDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
