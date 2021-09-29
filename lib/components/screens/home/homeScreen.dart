import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/IconBuilder.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/textStyles.dart';
import 'package:minbar_fl/components/widgets/BroadcastBox.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/ChipsTag.dart';
import '../profile/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavType navType = NavType.idle;
  static const List mediaItems = const [
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "مسيلمة الكذاب الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "الثقة",
    ),
    BroadcastBox(
      host: "مسيلمة الكذاب",
      field: "حوار",
      subject: "الثقة",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: DColors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
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
                      items: mediaItems
                          .map((e) =>
                              Container(height: 113, width: 265, child: e))
                          .toList()),
                ),
              ])),
              SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: StickyShipTag(
                    child: ChipsTag(items: ["الكل", "ختبة", "درس", "حوار"]),
                    minHeight: 47,
                    maxHeight: 47,
                  )),
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
                            child: mediaItems[index]),
                        childCount: mediaItems.length)),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBar(selectedIndex: 0),
    );
  }
}
