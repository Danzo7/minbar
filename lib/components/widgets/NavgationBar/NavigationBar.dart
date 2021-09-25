import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/widgets/IconBuilder.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

import '../TextPlay.dart';
import 'NavigationPainter.dart';

enum NavType { broadcastable, listen, idle }

class NavigationBar extends StatefulWidget {
  final navType;
  static const List menuItems = ["home", "article", "profile", "settings"];
  static const idlePainter = const NavigationPainter(type: NavType.idle);
  static const broadcastPainter =
      const NavigationPainter(type: NavType.broadcastable);
  static const listenPainter = const NavigationPainter(type: NavType.listen);

  const NavigationBar({Key? key, this.navType = NavType.idle})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  static final Widget broadcastButton = Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 20),
    child: FlatIconButton(
      iconName: "broadcast",
      backgroundColor: DColors.sadRed,
      onTap: () {},
    ),
  );
  static final Widget listenButton = Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 30),
    child: FlatIconButton(
      backgroundColor: DColors.blueGray,
      iconName: "listening",
      onTap: () => {},
    ),
  );

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
      height: widget.navType == NavType.idle ? 80 : 100,
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: widget.navType == NavType.idle
                ? NavigationBar.idlePainter
                : widget.navType == NavType.broadcastable
                    ? NavigationBar.broadcastPainter
                    : NavigationBar.listenPainter,
          ),
          if (widget.navType == NavType.listen) listenButton,
          if (widget.navType == NavType.broadcastable) broadcastButton,
          Container(
            width: size.width,
            height: 80,
            child: Row(
              textDirection: TextDirection
                  .ltr, //this is the native direction on nabar,its does not matter if the ocalization is rtl or ltr.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: IconBuilder("home", fill: currentIndex == 0),
                  onPressed: () {
                    if (currentIndex != 0) setBottomBarIndex(0);
                  },
                ),
                IconButton(
                    icon: IconBuilder("article", fill: (currentIndex == 1)),
                    onPressed: () {
                      if (currentIndex != 1) setBottomBarIndex(1);
                      Navigator.pushReplacementNamed(context, '/showcase');
                    }),
                if (widget.navType != NavType.idle)
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: size.width * 0.20,
                    child: widget.navType == NavType.listen
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                TextPlay(
                                    textAlign: TextAlign.center,
                                    minFontSize: 10,
                                    marquee: Marquee(
                                      showFadingOnlyWhenScrolling: true,
                                      fadingEdgeEndFraction: 0.1,
                                      text: "سوء الضنا الضنا الضنا",
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
                    icon: IconBuilder("profile", fill: currentIndex == 2),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                IconButton(
                    icon: IconBuilder("settings", fill: currentIndex == 3),
                    onPressed: () {
                      if (currentIndex != 3) setBottomBarIndex(3);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
