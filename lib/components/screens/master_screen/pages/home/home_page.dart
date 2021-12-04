import 'package:flutter/material.dart';
import 'package:minbar_fl/components/common/recommandations/widgets/recommand_carousel.dart';
import 'package:minbar_fl/components/common/timelines/posts_timeline/widgets/post_list.dart/post_list.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/widgets/chips_tag.dart';
import 'package:minbar_fl/components/widgets/misc/timeline.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const String route = 'general';
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Timeline(
      key: PageStorageKey(route),
      physics: BouncingScrollPhysics(),
      header: StickyChipTag(
        border: BorderSides.bottom,
        items: FakeData.fields,
        bgColor: DColors.white,
      ),
      refreshController: _refreshController,
      content: PostList(title: Text("مقالات", style: DTextStyle.bg20s)),
      beforeRefreshSlivers: [
        RecommandCarousel(
          FakeData.casts,
          title: "يبث الان",
        ),
      ],
    );
  }

  SnapScrollPhysics snap() {
    return SnapScrollPhysics(parent: BouncingScrollPhysics(), snaps: [
      Snap(150,
          distance:
              50), // If the scroll offset is expected to stop between 150-250 the scroll will snap to 200,
      Snap(150,
          leadingDistance:
              50), // If the scroll offset is expected to stop  between 150-200 the scroll will snap to 200,
      Snap(150,
          trailingDistance:
              50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
      Snap.avoidZone(0,
          150), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
      Snap.avoidZone(0, 150,
          delimiter:
              50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
    ]);
  }
}
