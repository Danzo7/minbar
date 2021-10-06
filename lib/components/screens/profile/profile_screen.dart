import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/components/static/fake_data.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

import 'widgets/gravity_header_scroll_view.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
//set this to false in case of assertion exception "Failed assertion: line 659 pos 12: '_hold == null': is not true".
//the error is related to this issue:https://github.com/flutter/flutter/issues/91166.
//the only way to fix this issue was by editing flutter source code.
  static bool _bugIsFixed = false;
  static const double _maxHeaderHieght = 300;
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
        selectedIndex: 2,
        withSafeArea: true,
        body: Container(
          alignment: Alignment.topCenter,
          child: !_bugIsFixed
              ? RefreshIndicator(
                  edgeOffset: _maxHeaderHieght + 47,
                  displacement: 100,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () =>
                      Future.delayed(Duration(seconds: 1), () => {true}),
                  child: CustomScrollView(
                      physics: SnapScrollPhysics(
                          parent: BouncingScrollPhysics(),
                          snaps: [
                            Snap(_maxHeaderHieght,
                                distance:
                                    50), // If the scroll offset is expected to stop between 150-250 the scroll will snap to 200,
                            Snap(_maxHeaderHieght,
                                leadingDistance:
                                    50), // If the scroll offset is expected to stop  between 150-200 the scroll will snap to 200,
                            Snap(_maxHeaderHieght,
                                trailingDistance:
                                    50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
                            Snap(_maxHeaderHieght,
                                trailingDistance:
                                    50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
                            Snap.avoidZone(0,
                                _maxHeaderHieght), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
                            Snap.avoidZone(0, _maxHeaderHieght,
                                delimiter:
                                    50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
                          ]),
                      slivers: [
                        ProfileHeader(
                          maxHeight: _maxHeaderHieght,
                          minHeight: 33,
                        ),
                        StickyChipTag(
                          items: FakeData.fields,
                        ),
                        _postList(FakeData.pub)
                      ]),
                )
              : GraviryHeaderScrollView(
                  slivers: [
                    ProfileHeader(
                      maxHeight: 300,
                      minHeight: 33,
                    ),
                    StickyChipTag(
                      items: FakeData.fields,
                    ),
                    _postList(FakeData.pub)
                  ],
                  gravityField: 300,
                ),
        ));
  }

  SliverPadding _postList(List<Publication> items) {
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 80, right: 15, left: 15, top: 20),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Post(items[index])),
                childCount: items.length)));
  }
}
