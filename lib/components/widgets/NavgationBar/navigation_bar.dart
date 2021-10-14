import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/screens/broadcast/Broadcast_page.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  final PageController? pageController;
  const NavigationBar(
      {Key? key,
      this.type = NavType.idle,
      required this.selectedIndex,
      required this.items,
      this.pageController})
      : assert(items.length % 2 == 0),
        super(key: key);

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(selectedIndex, pageController);
}

class _NavigationBarState extends State<NavigationBar> {
  final PageController? pageController;
  static final Widget listenButton = Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 30),
    child: FlatIconButton(
      backgroundColor: DColors.blueGray,
      icon: Icon(SodaIcons.listening, size: 24, color: DColors.white),
      onTap: () => {},
    ),
  );

  int currentIndex;
  _NavigationBarState(this.currentIndex, this.pageController);
  setBottomBarIndex(index) {
    if (currentIndex != index)
      setState(() {
        if (pageController != null) {
          pageController?.jumpToPage(index);
        }
        currentIndex = index;
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
          if (widget.type == NavType.listen) listenButton,
          if (widget.type == NavType.broadcastable) broadcastButton(context),
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
                              child: widget.type == NavType.listen
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                          TextPlay(
                                              textAlign: TextAlign.center,
                                              minFontSize: 10,
                                              marquee: Marquee(
                                                showFadingOnlyWhenScrolling:
                                                    true,
                                                fadingEdgeEndFraction: 0.1,
                                                text: "سوء الضنا الضنا الضنا",
                                                style: TextStyle(
                                                    color: DColors.white,
                                                    fontSize: 12),
                                                blankSpace: 50,
                                                velocity: 20.0,
                                              )),
                                          Divider(
                                            color: DColors.white,
                                            thickness: 2,
                                          )
                                        ])
                                  : null,
                            ),
                          IconButton(
                              icon: currentIndex == widget.items.indexOf(e)
                                  ? e.beforeIcon
                                  : e.afterIcon,
                              onPressed: () {
                                if (currentIndex != widget.items.indexOf(e)) {
                                  setBottomBarIndex(widget.items.indexOf(e));
                                  if (pageController == null)
                                    Navigator.popAndPushNamed(context, e.route);
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

  Container broadcastButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 20),
      child: FlatIconButton(
        icon: Icon(SodaIcons.broadcast, size: 24, color: DColors.white),
        backgroundColor: DColors.sadRed,
        onTap: () {
          showMaterialModalBottomSheet(
            expand: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            clipBehavior: Clip.antiAlias,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
                child: Container(
              child: SlidingUpPanel(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(40), right: Radius.circular(40)),
                  boxShadow: [],
                  minHeight: 600,
                  maxHeight: MediaQuery.of(context).size.height,
                  panel: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(40),
                          right: Radius.circular(40)),
                    ),
                    child: BroadcastPage(600),
                  )),
            )),
          );
        },
      ),
    );
  }
}
