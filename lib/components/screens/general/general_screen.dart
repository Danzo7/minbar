import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/widgets/broadcast_box.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_carousel.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class GeneralScreen extends StatelessWidget {
  final component;
  const GeneralScreen({Key? key, this.component}) : super(key: key);
  static const String route = 'general';

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
        selectedIndex: 1,
        body: RefreshIndicator(
          edgeOffset: 173 + 47,
          displacement: 100,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () => Future.delayed(Duration(seconds: 1), () => {true}),
          child: CustomScrollView(
            physics: snap(),
            slivers: [
              StickyChipTag(
                items: FakeData.fields,
                bgColor: DColors.white,
              ),
              SliverHeaderCarousel(
                carousel: CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 116.0,
                        reverse: true),
                    items: FakeData.casts
                        .map((e) => Container(
                            height: 113, width: 265, child: BroadcastBox(e)))
                        .toList()),
                title: Text("الاكثر تفاعلا", style: DTextStyle.bg20s),
                minHeight: 0,
                maxHeight: 173,
              ),
              SliverPadding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 20),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Post(FakeData.pub[index])),
                          childCount: FakeData.pub.length))),
            ],
          ),
        ));
  }

  SnapScrollPhysics snap() {
    return SnapScrollPhysics(parent: BouncingScrollPhysics(), snaps: [
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
    ]);
  }
}
