import 'package:flutter/material.dart';

import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

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
  final NavgationController? navigationController;
  const NavigationBar({
    Key? key,
    this.type = NavType.idle,
    required this.selectedIndex,
    required this.items,
    this.navigationController,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.selectedIndex;
    super.initState();
    widget.navigationController?.addChangeListener(setBottomBarIndex);
  }

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    widget.navigationController?.addChangeListener(setBottomBarIndex);
    super.didUpdateWidget(oldWidget);
  }

  setBottomBarIndex(index) {
    if (currentIndex != index)
      setState(() {
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
                                  widget.navigationController != null
                                      ? widget.navigationController
                                          ?.navigateTo(widget.items.indexOf(e))
                                      : app<MinbarNavigator>().navigateTo(
                                          context, widget.items.indexOf(e));
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
