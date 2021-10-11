import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/broadcast_box.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String route = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavType navType = NavType.idle;
  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      selectedIndex: 0,
      withSafeArea: true,
      body: Container(
        child: CustomScrollView(
          physics: SnapScrollPhysics(parent: BouncingScrollPhysics(), snaps: [
            Snap(173,
                distance:
                    50), // If the scroll offset is expected to stop between 150-250 the scroll will snap to 200,
            Snap(173,
                leadingDistance:
                    50), // If the scroll offset is expected to stop  between 150-200 the scroll will snap to 200,
            Snap(173,
                trailingDistance:
                    50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
            Snap(173,
                trailingDistance:
                    50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
            Snap.avoidZone(0,
                173), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
            Snap.avoidZone(0, 173,
                delimiter:
                    50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
          ]),
          slivers: [
            SliverToBoxAdapter(
                child: Wrap(spacing: 10, children: [
              Container(
                child: Text("الاكثر تفاعلا", style: DTextStyle.bg20s),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 116.0,
                        reverse: true),
                    items: FakeData.casts
                        .map((e) => Container(
                            height: 113, width: 265, child: BroadcastBox(e)))
                        .toList()),
              ),
            ])),
            StickyChipTag(items: FakeData.fields),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    const Text("يبث الان", style: DTextStyle.bg20s),
                    const IconBuilder("live", color: DColors.sadRed),
                  ],
                ),
                height: 70,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            left: 33, bottom: 10, right: 33),
                        child: BroadcastBox(FakeData.casts[index],
                            key: Key('key-$index'))),
                    childCount: FakeData.casts.length)),
          ],
        ),
      ),
    );
  }
}
