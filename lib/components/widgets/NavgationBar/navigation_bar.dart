import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

import '../text_play.dart';
import 'navigation_item.dart';
import 'navigation_painter.dart';

const idlePainter = const NavigationPainter(type: NavType.idle);
const broadcastPainter = const NavigationPainter(type: NavType.broadcastable);
const listenPainter = const NavigationPainter(type: NavType.listen);

enum NavType { broadcastable, listen, idle }

class NavigationBar extends StatefulWidget {
  final NavType type;
  final int selectedIndex;
  final List<NavigatonItem> items;
  const NavigationBar({
    Key? key,
    this.type = NavType.idle,
    required this.selectedIndex,
    required this.items,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState(selectedIndex);
}

class _NavigationBarState extends State<NavigationBar> {
  static final Widget listenButton = Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(
      children: [
        FlatIconButton(
          backgroundColor: DColors.blueGray,
          icon: Icon(SodaIcons.listening, size: 24, color: DColors.white),
          onTap: () => {},
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextPlay(
              textAlign: TextAlign.center,
              minFontSize: 10,
              marquee: Marquee(
                showFadingOnlyWhenScrolling: true,
                fadingEdgeEndFraction: 0.1,
                text: "سوء الضنا الضنا الضنا",
                style: TextStyle(color: DColors.white, fontSize: 12),
                blankSpace: 50,
                velocity: 20.0,
              )),
          Divider(
            color: DColors.white,
            thickness: 2,
          )
        ])
      ],
    ),
  );

  int currentIndex;
  _NavigationBarState(this.currentIndex);
  setBottomBarIndex(index) {
    if (currentIndex != index)
      setState(() {
        currentIndex = index;
        Pager.navigateTo(context, index);
      });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: widget.type == NavType.idle ? 80 : 100,
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: widget.type == NavType.idle
                ? idlePainter
                : widget.type == NavType.broadcastable
                    ? broadcastPainter
                    : listenPainter,
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              textDirection: TextDirection
                  .ltr, //this is the native direction on nabar,its does not matter if the ocalization is rtl or ltr.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...widget.items
                    .map((e) => [
                          if (widget.items.indexOf(e) ==
                                  widget.items.length / 2 &&
                              widget.type != NavType.idle)
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: size.width * 0.20,
                            ),
                          IconButton(
                              icon: currentIndex == widget.items.indexOf(e)
                                  ? e.beforeIcon
                                  : e.afterIcon,
                              onPressed: () {
                                if (currentIndex != widget.items.indexOf(e)) {
                                  setBottomBarIndex(widget.items.indexOf(e));
                                }
                              })
                        ])
                    .expand((i) => i)
                    .toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
