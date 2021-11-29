import 'dart:math';
import 'package:minbar_fl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/avatar.dart';

import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/model/user.dart';

class ProfileHeader extends StatelessWidget {
  final double? minHeight;
  final double maxHeight;
  final bool shrink;
  final UserData user;
  final bool hasPopularity;
  const ProfileHeader(
      {Key? key,
      this.minHeight,
      required this.maxHeight,
      this.shrink = true,
      this.hasPopularity = true,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: false,
        floating: false,
        delegate: _SliverProfileHeader(
            minHeight: minHeight,
            maxHeight: maxHeight,
            shrink: shrink,
            hasPopularity: hasPopularity,
            user: user));
  }
}

class _SliverProfileHeader extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double maxHeight;
  final bool shrink;
  final UserData user;
  final bool hasPopularity;
  _SliverProfileHeader(
      {this.minHeight,
      required this.maxHeight,
      required this.shrink,
      required this.hasPopularity,
      required this.user});

  @override
  double get minExtent => minHeight ?? maxHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight ?? maxHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage =
        shrink ? min(1, shrinkOffset / (maxExtent - minExtent)) : 0;
    return AnimatedOpacity(
      opacity: shrinkPercentage > 0.1 ? 0 : 1,
      duration: kFlashAnimationDuration,
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 10,
          children: [
            profilePicture(shrinkPercentage),
            userInfo(),
            if (hasPopularity) userPopularity(shrinkPercentage),
          ],
        ),
      ),
    );
  }

  Container userPopularity(double shrinkPercentage) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: DColors.coldGray),
          borderRadius: BorderRadius.circular(22)),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          NotAButton(
              raduis: 20,
              borderColor: DColors.coldGray,
              child: Container(
                width: 50,
                height: 30 + 50 * (1 - shrinkPercentage),
                alignment: Alignment.center,
                child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("يتابع", style: DTextStyle.bg10),
                      Text(user.following.toString(), style: DTextStyle.bg16)
                    ]),
              )),
          if (!user.description.isNull)
            Text(
              user.description!,
              style: DTextStyle.bg10,
            ),
          NotAButton(
              raduis: 20,
              borderColor: DColors.coldGray,
              child: Container(
                width: 50,
                height: 30 + 50 * (1 - shrinkPercentage),
                alignment: Alignment.center,
                child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("يتابعه", style: DTextStyle.bg10),
                      Text(user.following.toString(), style: DTextStyle.bg16)
                    ]),
              ))
        ],
      ),
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
            Text(user.fullName.toString(), style: DTextStyle.bg16s),
            const IconBuilder("aprovedState")
          ],
        ),
        Text("امام", style: DTextStyle.b15)
      ],
    );
  }

  Widget profilePicture(double shrinkPercentage) {
    return Avatar(user.avatarUrl, raduis: 45 * (1 - shrinkPercentage) + 15);
  }

  @override
  bool shouldRebuild(_SliverProfileHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}
