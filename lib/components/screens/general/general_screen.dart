import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/fake_data.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';

class GeneralScreen extends StatelessWidget {
  final component;
  const GeneralScreen({Key? key, this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DColors.white,
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            StickyChipTag(
              items: FakeData.fields,
              bgColor: DColors.white,
            ),
            SliverPadding(
                padding:
                    EdgeInsets.only(bottom: 80, right: 15, left: 15, top: 20),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Post(FakeData.pub[index])),
                        childCount: FakeData.pub.length))),
          ],
        ),
        bottomNavigationBar: const NavigationBar(selectedIndex: 1));
  }
}
