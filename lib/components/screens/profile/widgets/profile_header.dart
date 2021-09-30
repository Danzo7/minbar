import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/text_styles.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.wheel,
  }) : super(key: key);

  final ScrollController wheel;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: false,
        floating: false,
        delegate: _SliverProfileHeader(
          wheel: wheel,
          minHeight: 33,
          maxHeight: 300,
        ));
  }
}

class _SliverProfileHeader extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final ScrollController wheel;
  _SliverProfileHeader({
    required this.wheel,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage = min(1, shrinkOffset / (maxExtent - minExtent));
    if (shrinkPercentage < 1 && shrinkPercentage > 0.1) {
      if (wheel.position.userScrollDirection == ScrollDirection.reverse) {
        wheel.animateTo(maxHeight,
            duration: Duration(milliseconds: 70), curve: Curves.easeOutCubic);
      } else {
        wheel.animateTo(0,
            duration: Duration(milliseconds: 70), curve: Curves.easeOutCubic);
      }
    }
    return AnimatedOpacity(
      opacity: 1 - shrinkPercentage,
      duration: Duration(milliseconds: 10),
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          children: [
            profilePicture(shrinkPercentage),
            userInfo(),
            userPopularity(shrinkPercentage),
          ],
        ),
      ),
    );
  }

  Wrap userPopularity(double shrinkPercentage) {
    return Wrap(
      spacing: 5,
      children: [
        NotAButton(
            raduis: 20,
            width: 80,
            height: 30 + 50 * (1 - shrinkPercentage),
            backgroundColor: DColors.sailBlue,
            child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("المتابعون", style: DTextStyle.w15s),
                  Text("15", style: DTextStyle.w15s)
                ])),
        NotAButton(
            raduis: 20,
            width: 80,
            height: 30 + 50 * (1 - shrinkPercentage),
            backgroundColor: DColors.sailBlue,
            child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("المتابعون", style: DTextStyle.w15s),
                  Text("15", style: DTextStyle.w15s)
                ]))
      ],
    );
  }

  Wrap userInfo() {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Text("مسيلمة الكذاب", style: DTextStyle.bg16s),
            const IconBuilder("aprovedState")
          ],
        ),
        Text("امام", style: DTextStyle.b15)
      ],
    );
  }

  ClipOval profilePicture(double shrinkPercentage) {
    return ClipOval(
        child: Container(
            height: 70 * (1 - shrinkPercentage) + 27,
            width: 70 * (1 - shrinkPercentage) + 30,
            child: Image.asset(
              "assets/images/profilePicture.png",
              fit: BoxFit.fitWidth,
            )));
  }

  @override
  bool shouldRebuild(_SliverProfileHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
