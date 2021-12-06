import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/common/recommandations/widgets/recommand_carousel.dart';
import 'package:minbar_fl/components/common/timelines/broadcasts_timeline/bloc/casts_bloc.dart';
import 'package:minbar_fl/components/common/timelines/broadcasts_timeline/widgets/broadcast_list.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/misc/timeline.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_head.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class BroadcastsPage extends StatelessWidget {
  BroadcastsPage({Key? key}) : super(key: key);
  static const String route = 'lb_screen';
  final _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Timeline(
        physics: snap(),
        key: PageStorageKey(route),
        refreshController: _refreshController,
        header: RecommandCarousel(
          FakeData.casts,
          title: "الاكثر استماعا",
        ),
        beforeRefreshSlivers: [
          StickyChipTag(items: FakeData.fields),
          SliverHead(
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
          ),
        ],
        content: BroadcastList(),
      ),
    );
  }

  SnapScrollPhysics snap() {
    return SnapScrollPhysics(parent: BouncingScrollPhysics(), snaps: [
      // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
      Snap.avoidZone(0, 173,
          delimiter:
              50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
    ]);
  }
}
