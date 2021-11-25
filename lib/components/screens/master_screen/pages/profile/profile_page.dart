import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/common/timelines/posts_timeline/widgets/post_list.dart/post_list.dart';
import 'package:minbar_fl/components/theme/snaps.dart';
import 'package:minbar_fl/components/widgets/misc/refresh_content_page.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'widgets/gravity_header_scroll_view.dart';
import '../../../../widgets/slivers/profile_header.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const String route = 'profile';

  ///set this to false in case of assertion exception ``Failed assertion: line 659 pos 12: '_hold == null': is not true``.
  ///the error is related to this issue:https://github.com/flutter/flutter/issues/91166.
  ///the only way to fix this issue was by editing flutter source code.
  static final bool _bugIsFixed = false;

  static const double _maxHeaderHieght = 300;
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: !ProfilePage._bugIsFixed
          ? Timeline(
              refreshController: _refreshController,
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
              content: PostList(FakeData.pub),
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
                PostList(FakeData.pub)
              ],
              gravityField: 300,
            ),
    );
  }
}
