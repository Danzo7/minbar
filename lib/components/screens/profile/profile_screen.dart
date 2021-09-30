import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/fake_data.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';

import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ScrollController wheel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DColors.white,
        extendBody: true,
        bottomNavigationBar: const NavigationBar(selectedIndex: 2),
        body: SafeArea(
          bottom: false,
          child: Container(
            alignment: Alignment.topCenter,
            child: CustomScrollView(controller: wheel, slivers: [
              ProfileHeader(wheel: wheel),
              StickyChipTag(
                items: FakeData.fields,
              ),
              postList()
            ]),
          ),
        ));
  }

  SliverPadding postList() {
    return SliverPadding(
        padding: EdgeInsets.only(bottom: 80, right: 15, left: 15, top: 20),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Post(FakeData.pub[index])),
                childCount: FakeData.pub.length)));
  }
}
