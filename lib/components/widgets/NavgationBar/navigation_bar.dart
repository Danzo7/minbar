import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'animated_painterd.dart';
import 'middle_controller.dart';
import 'navigation_item.dart';

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

  @override
  void initState() {
    currentIndex = widget.selectedIndex;
    widget.middleController.addListener(listener);
    super.initState();

    widget.navigationController?.addChangeListener(setBottomBarIndex);
  }

  @override
  void didUpdateWidget(covariant NavigationBar oldWidget) {
    widget.navigationController?.addChangeListener(setBottomBarIndex);

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
                                    widget.navigationController != null
                                        ? widget.navigationController
                                            ?.navigateTo(
                                                widget.items.indexOf(e))
                                        : app<MinbarNavigator>().navigateTo(
                                            context, widget.items.indexOf(e));
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

class DragBili extends StatefulWidget {
  const DragBili({Key? key}) : super(key: key);

  @override
  State<DragBili> createState() => _DragBiliState();
}

class _DragBiliState extends State<DragBili> {
  double _horizontalPos = 0.0;
  double _verticalPos = 0.0;
  ValueNotifier<List<double>> posValueListener = ValueNotifier([0.0, 0.0]);
  ValueChanged<List<double>>? posValueChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 100),
        color: Colors.green,
        child: Builder(
          builder: (context) {
            final handle = GestureDetector(
                onPanUpdate: (details) {
                  _verticalPos =
                      (_verticalPos + details.delta.dy / (size.height))
                          .clamp(.0, 1.0);
                  _horizontalPos =
                      (_horizontalPos + details.delta.dx / (size.width))
                          .clamp(.0, 1.0);
                  posValueListener.value = [_horizontalPos, _verticalPos];
                },
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    width: 110.0,
                    height: 170.0,
                    child: Container(
                      color: Colors.black87,
                    ),
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ));

            return ValueListenableBuilder<List<double>>(
              valueListenable: posValueListener,
              builder:
                  (BuildContext context, List<double> value, Widget? child) {
                return Align(
                  alignment: Alignment(value[0] * 2 - 1, value[1] * 2 - 1),
                  child: handle,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
    // if (state.currentCast != null) {
    //         mad = mad == animationDirection.idle
    //             ? animationDirection.forward
    //             : animationDirection.completed;
    //       } else {
    //         if (mad != animationDirection.idle)
    //           mad = mad == animationDirection.forward
    //               ? animationDirection.backward
    //               : animationDirection.idle;
    //       }