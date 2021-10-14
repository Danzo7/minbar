import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/broadcast_box.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/misc/refresh_content_page.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_carousel.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_container.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class BroadcastsPage extends StatefulWidget {
  BroadcastsPage({Key? key}) : super(key: key);
  static const String route = 'lb_screen';

  @override
  _BroadcastsPageState createState() => _BroadcastsPageState();
}

class _BroadcastsPageState extends State<BroadcastsPage> {
  List<Publication> items = [FakeData.pub[0]];
  final _refreshController = new RefreshController();
  int count = 0;

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      _additem();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      if (count < FakeData.pub.length - 1) {
        _loadMore();
        _refreshController.loadComplete();
      } else
        _refreshController.loadNoData();
    });
  }

  _additem() {
    items = [
      Publication(
          authorName: "خة",
          authorAvatar: "assets/images/cover.png",
          content: "هو الحق",
          type: "لقاء",
          date: DateTime.now(),
          likeCount: 65,
          pinCount: 11,
          hasPodcast: false),
      ...items
    ];
    if (mounted) setState(() {});
  }

  _loadMore() {
    count++;

    items.add(FakeData.pub[count]);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      selectedIndex: 0,
      withSafeArea: true,
      body: Container(
        child: RefreshContentPage(
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
          refreshController: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: SliverHeaderCarousel(
            carousel: CarouselSlider(
                options: CarouselOptions(
                    enableInfiniteScroll: false, height: 116.0, reverse: true),
                items: FakeData.casts
                    .map((e) => Container(
                        height: 113, width: 265, child: BroadcastBox(e)))
                    .toList()),
            title: Text("الاكثر تفاعلا", style: DTextStyle.bg20s),
            minHeight: 0,
            maxHeight: 173,
          ),
          beforeRefreshSlivers: [
            StickyChipTag(items: FakeData.fields),
            SliverPersistentHeader(
                delegate: SliverHeaderContainer(
              maxHeight: 70,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Text("يبث الان", style: DTextStyle.bg20s),
                    const IconBuilder("live", color: DColors.sadRed),
                  ],
                ),
              ),
            )),
          ],
          afterRefreshSlivers: [
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

  Wrap _popularBroadcasts() {
    return Wrap(spacing: 10, children: [
      Container(
        child: Text("الاكثر تفاعلا", style: DTextStyle.bg20s),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false, height: 116.0, reverse: true),
            items: FakeData.casts
                .map((e) =>
                    Container(height: 113, width: 265, child: BroadcastBox(e)))
                .toList()),
      ),
    ]);
  }
}
