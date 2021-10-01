import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/fake_data.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/static/default_colors.dart';
import 'package:minbar_fl/components/static/default_text_styles.dart';
import 'package:minbar_fl/components/widgets/broadcast_box.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/slivers/sticky_chips_tag.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavType navType = NavType.idle;
  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      selectedIndex: 0,
      withSafeArea: true,
      body: Container(
        child: CustomScrollView(
          physics: RangeMaintainingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
                child: Wrap(spacing: 10, children: [
              Container(
                child: Text("الاكثر تفاعلا", style: DTextStyle.bg20s),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 116.0,
                        reverse: true),
                    items: FakeData.casts
                        .map((e) => Container(
                            height: 113, width: 265, child: BroadcastBox(e)))
                        .toList()),
              ),
            ])),
            StickyChipTag(items: FakeData.fields),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    const Text("يبث الان", style: DTextStyle.bg20s),
                    const IconBuilder("live", color: DColors.sadRed),
                  ],
                ),
                height: 70,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 80),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 33, bottom: 10, right: 33),
                          child: BroadcastBox(
                            FakeData.casts[index],
                          )),
                      childCount: FakeData.casts.length)),
            )
          ],
        ),
      ),
    );
  }
}
