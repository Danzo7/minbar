import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/animated_painterd.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/middle_controller.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

class NavigationBar extends StatefulWidget {
  final MiddleController middleController;
  final int selectedIndex;
  final List<NavigatonItem> items;
  final NavgationController? navigationController;

  const NavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    this.navigationController,
    required this.middleController,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;
  AnimationDirection mad = AnimationDirection.idle;
  late final NavgationController? navigationController;

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

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    navigationController?.addChangeListener(setBottomBarIndex);

    widget.middleController.addListener(listener);
    super.didUpdateWidget(oldWidget);
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
            AnimatedPainter(direction: mad, isInside: false, max: 15),
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
                              ),
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
