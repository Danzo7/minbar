import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/theme/snaps.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/misc/refresh_content_page.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'widgets/gravity_header_scroll_view.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  ///set this to false in case of assertion exception ``Failed assertion: line 659 pos 12: '_hold == null': is not true``.
  ///the error is related to this issue:https://github.com/flutter/flutter/issues/91166.
  ///the only way to fix this issue was by editing flutter source code.
  static bool _bugIsFixed = false;
  static const double _maxHeaderHieght = 300;
  ProfileScreen({Key? key}) : super(key: key);
  static const String route = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Publication> items = [FakeData.pub[0]];
  final _refreshController = new RefreshController();
  int count = 0;
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      additem();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      if (count < FakeData.pub.length - 1) {
        loadMore();
        _refreshController.loadComplete();
      } else
        _refreshController.loadNoData();
    });
  }

  additem() {
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

  loadMore() {
    count++;

    items.add(FakeData.pub[count]);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
        selectedIndex: 2,
        withSafeArea: true,
        body: Container(
          alignment: Alignment.topCenter,
          child: !ProfileScreen._bugIsFixed
              ? RefreshContentPage(
                  refreshController: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  physics: Snaps.profileHeaderSnap(),
                  header: ProfileHeader(
                    maxHeight: ProfileScreen._maxHeaderHieght,
                    minHeight: 33,
                  ),
                  beforeRefreshSlivers: [
                    StickyChipTag(
                      items: FakeData.fields,
                    )
                  ],
                  afterRefreshSlivers: [_postList(items)],
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
                    _postList(items)
                  ],
                  gravityField: 300,
                ),
        ));
  }

  SliverPadding _postList(List<Publication> items) {
    return SliverPadding(
        padding: EdgeInsets.only(right: 15, left: 15, top: 20),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Post(items[index])),
          childCount: items.length,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
        )));
  }
}
