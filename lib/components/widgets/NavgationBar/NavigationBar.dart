import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/static/Icons.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

import '../TextPlay.dart';
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
                      0.6 - (widget.navType == NavType.listen ? 0.4 : 0),
                  child: FlatIconButton(
                      backgroundColor: widget.navType == NavType.broadcastable
                          ? DColors.sadRed
                          : DColors.blueGray,
                      child: DIcons.getIcon(
                          widget.navType == NavType.broadcastable
                              ? IconList.broadcast
                              : IconList.listening),
                      onTap: () {}),
                )
              : SizedBox(),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              textDirection: TextDirection
                  .ltr, //this is the native direction on nabar,its does not matter if the ocalization is rtl or ltr.
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
                  alignment: Alignment.bottomCenter,
                  width: widget.navType != NavType.idle ? size.width * 0.20 : 0,
                  child: widget.navType == NavType.listen
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              TextPlay(
                                  textAlign: TextAlign.center,
                                  minFontSize: 10,
                                  marquee: Marquee(
                                    text: "سوء الضنا",
                                    style: TextStyle(
                                        color: DColors.white, fontSize: 12),
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
                    icon: DIcons.getIcon(IconList.profile,
                        filled: currentIndex == 2),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'LoginScreen');
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
