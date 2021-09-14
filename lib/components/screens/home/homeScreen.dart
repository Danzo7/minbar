import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/BroadcastBox.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavType navType = NavType.idle;
  List mediaItems = [
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                Text("تغيير وضع القائمة"),
                color: DColors.blueGray,
                onClick: () => setState(() => {
                      navType = navType != NavType.listen
                          ? navType == NavType.broadcastable
                              ? NavType.listen
                              : NavType.broadcastable
                          : NavType.idle
                    }),
              ),
              CarouselSlider(
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: 116.0,
                      autoPlay: true,
                      reverse: true),
                  items: mediaItems
                      .map((e) => Container(height: 113, width: 265, child: e))
                      .toList()),
              SizedBox(
                height: 20,
              ),
              BroadcastsList(
                  mediaItems: mediaItems, direction: Axis.horizontal),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BroadcastsList(mediaItems: mediaItems),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(navType: navType),
    );
  }
}

class BroadcastsList extends StatelessWidget {
  const BroadcastsList({
    Key? key,
    required this.mediaItems,
    this.direction = Axis.vertical,
  }) : super(key: key);

  final List mediaItems;
  final direction;
  @override
  Widget build(BuildContext context) {
    return Container(
        //clipBehavior: Clip.none,
        height: direction == Axis.horizontal ? 113 : null,
        padding: direction == Axis.vertical
            ? EdgeInsets.symmetric(horizontal: 33)
            : null,
        child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: direction,
            children: direction == Axis.vertical
                ? mediaItems
                    .map((e) => Container(
                        padding: EdgeInsets.only(bottom: 10), child: e))
                    .toList()
                : mediaItems
                    .map((e) => Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 113,
                        width: 265,
                        child: e))
                    .toList()));
  }
}
