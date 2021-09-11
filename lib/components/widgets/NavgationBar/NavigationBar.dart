import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/Icons.dart';
import 'package:minbar_fl/components/static/colors.dart';

import 'NavigationPainter.dart';

enum NavType { broadcastable, listen, idle }

class NavigationBar extends StatefulWidget {
  final navType;
  final List menuItems = ["home", "article", "profile", "settings"];
  NavigationBar({Key? key, this.navType = NavType.idle}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: NavigationPainter(
                color: DColors.blueGray, type: widget.navType),
          ),
          widget.navType != NavType.idle
              ? Center(
                  heightFactor:
                      0.3 + (widget.navType != NavType.listen ? 0.3 : 0),
                  child: FloatingActionButton(
                      backgroundColor: DColors.blueGray,
                      child: Icon(Icons.shopping_basket),
                      elevation: 0.1,
                      onPressed: () {}),
                )
              : SizedBox(),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon:
                      DIcons.getIcon(IconList.home, filled: currentIndex == 0),
                  onPressed: () {
                    setBottomBarIndex(0);
                  },
                  splashColor: Colors.white,
                ),
                IconButton(
                    icon: DIcons.getIcon(IconList.article,
                        filled: currentIndex == 1),
                    onPressed: () {
                      setBottomBarIndex(1);
                    }),
                Container(
                  width: widget.navType != NavType.idle ? size.width * 0.20 : 0,
                ),
                IconButton(
                    icon: DIcons.getIcon(IconList.profile,
                        filled: currentIndex == 2),
                    onPressed: () {
                      setBottomBarIndex(2);
                    }),
                IconButton(
                    icon: DIcons.getIcon(IconList.settings,
                        filled: currentIndex == 3),
                    onPressed: () {
                      setBottomBarIndex(3);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
