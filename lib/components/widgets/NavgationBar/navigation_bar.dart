import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/animated_painterd.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/middle_controller.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';
import 'package:minbar_fl/components/widgets/text_play.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    this.navigationController,
    required this.middleController,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  final List<NavigatonItem> items;
  final MiddleController middleController;
  final NavgationController? navigationController;
  final int selectedIndex;

  @override
  _NavigationBarState createState() => _NavigationBarState();

  get state => null;
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;
  AnimationDirection mad = AnimationDirection.idle;
  late final NavgationController? navigationController;

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    navigationController?.addChangeListener(setBottomBarIndex);

    widget.middleController.addListener(listener);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    navigationController =
        app<MinbarNavigator>().pageKey.currentState?.navgationController ??
            widget.navigationController;

    currentIndex = widget.selectedIndex;
    widget.middleController.addListener(listener);
    super.initState();

    navigationController?.addChangeListener(setBottomBarIndex);
  }

  void listener() async {
    await rebuild(() {
      if (widget.middleController.isNormal) mad = AnimationDirection.backward;
      if (widget.middleController.isOut) mad = AnimationDirection.forward;
      if (widget.middleController.isIn) mad = AnimationDirection.forward;
    });
  }

  setBottomBarIndex(index) {
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  Future<bool> rebuild(void Function() fn) async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance!.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance!.endOfFrame;
      if (!mounted) return false;
    }

    setState(fn);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        height: 100,
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            AnimatedPainter(direction: mad, isInside: false, max: 12),
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
                                widget.items.length / 2)
                              AnimatedContainer(
                                  duration: kShortAnimationDuration,
                                  alignment: Alignment.bottomCenter,
                                  width: widget.middleController.isNormal
                                      ? 0
                                      : (size.width * 0.20),
                                  child: Consumer<CastService>(
                                      builder: (context, state, child) {
                                    return state.currentCast != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: TextPlay(
                                                textAlign: TextAlign.center,
                                                minFontSize: 10,
                                                marquee: Marquee(
                                                  showFadingOnlyWhenScrolling:
                                                      true,
                                                  fadingEdgeEndFraction: 0.1,
                                                  text: state
                                                      .currentCast!.subject,
                                                  style: DTextStyle.w12,
                                                  blankSpace: 50,
                                                  velocity: 20.0,
                                                )),
                                          )
                                        : SizedBox();
                                  })),
                            IconButton(
                                icon: currentIndex == widget.items.indexOf(e)
                                    ? e.beforeIcon
                                    : e.afterIcon,
                                onPressed: () {
                                  if (currentIndex != widget.items.indexOf(e)) {
                                    app<MinbarNavigator>()
                                        .navigateTo(widget.items.indexOf(e));
                                  }
                                })
                          ])
                      .expand((i) => i)
                      .toList()
                ],
              ),
            ),
          ],
        ));
  }
}
