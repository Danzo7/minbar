import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/components/static/fake_data.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';
import 'package:minbar_fl/model/publication.dart';

import 'widgets/gravity_header_scroll_view.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
//set this to false in case of assertion exception "Failed assertion: line 659 pos 12: '_hold == null': is not true".
//the error is related to this issue:https://github.com/flutter/flutter/issues/91166.
//the only way to fix this issue was by editing flutter source code.
  static bool _bugIsFixed = true;

  ProfileScreen({Key? key}) : super(key: key);
  final ScrollController wheel = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
        selectedIndex: 2,
        withSafeArea: true,
        body: Container(
          alignment: Alignment.topCenter,
          child: _bugIsFixed
              ? GraviryHeaderScrollView(
                  slivers: [
                    ProfileHeader(),
                    StickyChipTag(
                      items: FakeData.fields,
                    ),
                    _postList(FakeData.pub)
                  ],
                  gravityField: 300,
                )
              : CustomScrollView(controller: wheel, slivers: [
                  ProfileHeader(wheel: wheel),
                  StickyChipTag(
                    items: FakeData.fields,
                  ),
                  _postList(FakeData.pub)
                ]),
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