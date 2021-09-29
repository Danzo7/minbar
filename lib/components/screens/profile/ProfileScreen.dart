import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/fakeData.dart';
import 'package:minbar_fl/components/static/textStyles.dart';
import 'package:minbar_fl/components/widgets/ChipsTag.dart';
import 'package:minbar_fl/components/widgets/IconBuilder.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ScrollController wheel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DColors.white,
        extendBody: true,
        bottomNavigationBar: const NavigationBar(selectedIndex: 2),
        body: SafeArea(
          bottom: false,
          child: Container(
            alignment: Alignment.topCenter,
            child: CustomScrollView(controller: wheel, slivers: [
              SliverPersistentHeader(
                  pinned: false,
                  floating: false,
                  delegate: _SliverProfileInfo(
                    wheel: wheel,
                    minHeight: 33,
                    maxHeight: 300,
                  )),
              SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: StickyShipTag(
                    child: ChipsTag(items: ["الكل", "ختبة", "درس", "حوار"]),
                    minHeight: 47,
                    maxHeight: 47,
                  )),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Post(FakeData.pub[index])),
                          childCount: FakeData.pub.length)))
            ]),
          ),
        ));
  }
}

class _SliverProfileInfo extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final ScrollController wheel;
  _SliverProfileInfo({
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
    if (shrinkPercentage < 0.9 && shrinkPercentage > 0.2) {
      if (wheel.position.userScrollDirection == ScrollDirection.reverse) {
        wheel.animateTo(maxHeight,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      } else {
        wheel.animateTo(0,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
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
            ClipOval(
                child: Container(
                    height: 70 * (1 - shrinkPercentage) + 27,
                    width: 70 * (1 - shrinkPercentage) + 30,
                    child: Image.asset(
                      "assets/images/profilePicture.png",
                      fit: BoxFit.fitWidth,
                    ))),
            Wrap(
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
            ),
            Wrap(
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
            ),
          ],
        ),
      ),
    );
  }

  // 3
  @override
  bool shouldRebuild(_SliverProfileInfo oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight;
  }
}

class StickyShipTag extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  StickyShipTag({
    required this.child,
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
    return Container(
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(StickyShipTag oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 2 - 50,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 10,
        children: [
          ClipOval(
              child: Container(
                  height: 97,
                  width: 100,
                  child: Image.asset(
                    "assets/images/profilePicture.png",
                    fit: BoxFit.fitWidth,
                  ))),
          Wrap(
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
          ),
          Wrap(
            spacing: 5,
            children: [
              NotAButton(
                  raduis: 20,
                  width: 80,
                  height: 80,
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
                  height: 80,
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
          ),
        ],
      ),
    );
  }
}
