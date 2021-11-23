import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/common/timelines/posts_timeline/widgets/post_list.dart/post_list.dart';
import 'package:minbar_fl/components/theme/snaps.dart';
import 'package:minbar_fl/components/widgets/misc/refresh_content_page.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'widgets/gravity_header_scroll_view.dart';
import '../../../../widgets/slivers/profile_header.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const String route = 'profile';

  ///set this to false in case of assertion exception ``Failed assertion: line 659 pos 12: '_hold == null': is not true``.
  ///the error is related to this issue:https://github.com/flutter/flutter/issues/91166.
  ///the only way to fix this issue was by editing flutter source code.
  static bool _bugIsFixed = false;

  static const double _maxHeaderHieght = 300;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int count = 0;
  List<Publication> items = [FakeData.pub[0]];

  final _refreshController = new RefreshController();

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
        author: FakeData.currentUser,
        content: "هو الحق",
        date: DateTime.now(),
        heartCount: 65,
        pinCount: 11,
      ),
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
    return Container(
      alignment: Alignment.topCenter,
      child: !ProfilePage._bugIsFixed
          ? RefreshContentPage(
              refreshController: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              physics: Snaps.profileHeaderSnap(),
              header: ProfileHeader(
                user: FakeData.currentUser,
                maxHeight: ProfilePage._maxHeaderHieght,
                minHeight: 33,
              ),
              beforeRefreshSlivers: [
                StickyChipTag(
                  items: FakeData.fields,
                )
              ],
              content: PostList(items),
            )
          : GraviryHeaderScrollView(
              slivers: [
                ProfileHeader(
                  user: FakeData.currentUser,
                  maxHeight: 300,
                  minHeight: 33,
                ),
                StickyChipTag(
                  items: FakeData.fields,
                ),
                PostList(items)
              ],
              gravityField: 300,
            ),
    );
  }
}
