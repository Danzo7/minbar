import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/common/broadcast/cast/wdgets/broadcast_box.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_carousel.dart';
import 'package:minbar_fl/model/cast.dart';

///Only use as sliver
class RecommandCarousel extends StatelessWidget {
  final List<Cast> casts;
  final String title;
  const RecommandCarousel(this.casts, {Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverHeaderCarousel(
      title: Text(title, style: DTextStyle.bg20s),
      carousel: CarouselSlider(
          options: CarouselOptions(
              disableCenter: true,
              enableInfiniteScroll: false,
              height: 116.0,
              reverse: true),
          items: casts
              .map((e) => Padding(
                  padding: EdgeInsets.only(right: 30), child: BroadcastBox(e)))
              .toList()),
      minHeight: 0,
      maxHeight: 173,
    );
  }
}
