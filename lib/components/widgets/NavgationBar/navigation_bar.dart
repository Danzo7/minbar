import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/overlay_widget.dart';
import 'package:minbar_fl/components/widgets/text_play.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/core/services/cast_service.dart';

import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/misc/navigation.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../voice_visualisation.dart';
import 'navigation_item.dart';
import 'navigation_painter.dart';
import 'package:simple_animations/simple_animations.dart';

enum MiddleMode { normal, outside, inside }

class MiddleController extends ValueNotifier<MiddleMode> {
  MiddleController() : super(MiddleMode.normal);
  MiddleMode get mode => value;
  set mode(x) => value = x;

  bool get isNormal => value == MiddleMode.normal;
  bool get isOut => value == MiddleMode.outside;
  bool get isIn => value == MiddleMode.inside;
  void outside() => value = MiddleMode.outside;
  void normal() => value = MiddleMode.normal;
  void inside() => mode = MiddleMode.inside;
  void normOut() {
    if (isNormal)
      Random().nextBool() ? inside() : outside();
    else if (isOut || isIn) normal();
  }
}

enum animationDirection { forward, backward, idle, completed }

class AnimatedPainter extends StatelessWidget {
  final animationDirection direction;

  final double max;
  final bool isInside;
  const AnimatedPainter({
    Key? key,
    this.direction = animationDirection.idle,
    required this.max,
    this.isInside = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.direction == animationDirection.idle
        ? CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: NavigationPainter(pulling: 0))
        : this.direction == animationDirection.completed
            ? CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: NavigationPainter(
                    pulling: isInside ? 0 : max, pushing: isInside ? max : 0))
            : TweenAnimationBuilder<double?>(
                tween: this.direction == animationDirection.forward
                    ? Tween<double>(begin: 0, end: max)
                    : Tween<double>(begin: max, end: 0),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 100),
                builder: (context, value, child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 80),
                    painter: !isInside
                        ? NavigationPainter(pulling: value ?? 0)
                        : NavigationPainter(pushing: value),
                  );
                },
              );
  }
}

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
  animationDirection mad = animationDirection.idle;

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
      if (widget.middleController.isNormal) mad = animationDirection.backward;
      if (widget.middleController.isOut) mad = animationDirection.forward;
      if (widget.middleController.isIn) mad = animationDirection.forward;
    });
  }

  setBottomBarIndex(index) {
    if (currentIndex != index)
      setState(() {
        currentIndex = index;
      });
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
                                duration: Duration(milliseconds: 120),
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

class ActionButton extends StatelessWidget {
  final MiddleController middleController;
  final OverlayController overlayController = OverlayController();
  ActionButton({
    Key? key,
    required this.state,
    required this.middleController,
  }) : super(key: key);
  final CastService? state;
  @override
  Widget build(BuildContext context) {
    bool isSwipeUp = false;
    void action() => showBroadcastBottomSheet(
          context,
        );

    Widget dragablebubble(
        {required Widget child,
        required Widget broChild,
        Function? onDragComplete}) {
      return LongPressDraggable(
        maxSimultaneousDrags: 1,
        ignoringFeedbackSemantics: false,
        axis: Axis.vertical,
        child:
            Wrap(alignment: WrapAlignment.center, children: [child, broChild]),
        feedback: Material(
          child: child,
          color: Colors.transparent,
        ),
        onDragStarted: () {
          overlayController.show();

          middleController.normal();
        },
        onDragEnd: (details) {
          print([MediaQuery.of(context).size.height - 150, details.offset.dy]);
          if (MediaQuery.of(context).size.height - 150 > details.offset.dy) {
            if (onDragComplete != null) onDragComplete();
          }
          if (state?.currentCast != null) middleController.outside();

          overlayController.hide();
        },
        onDragUpdate: (details) {},
        childWhenDragging: SizedBox(),
      );
    }

    return (state == null || state?.currentCast == null)
        ? SizedBox()
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              OverlayBack(controller: overlayController),
              GestureDetector(
                onVerticalDragUpdate: (details) =>
                    isSwipeUp = details.delta.dy < 0 ? true : false,
                onVerticalDragEnd: (c) => {if (isSwipeUp) action()},
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 101,
                  width: MediaQuery.of(context).size.width / 5,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: StreamBuilder<PlayerState>(
                      stream: app<AudioService>().playerStateStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<PlayerState> snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        print(processingState);

                        return dragablebubble(
                            onDragComplete: state!.stopCast,
                            child: FlatIconButton(
                                backgroundColor: minbarTheme.secondary,
                                icon: (processingState ==
                                            ProcessingState.ready &&
                                        app<AudioService>().playerState.playing)
                                    ? VoiceVisualisation()
                                    : (processingState ==
                                                ProcessingState.buffering ||
                                            processingState ==
                                                ProcessingState.loading)
                                        ? CircularProgressIndicator()
                                        : Icon(
                                            Icons.pause,
                                            color: DColors.white,
                                          ),
                                onTap: action),
                            broChild: TextPlay(
                                textAlign: TextAlign.center,
                                minFontSize: 10,
                                marquee: Marquee(
                                  showFadingOnlyWhenScrolling: true,
                                  fadingEdgeEndFraction: 0.1,
                                  text: state!.currentCast!.subject,
                                  style: DTextStyle.w12,
                                  blankSpace: 50,
                                  velocity: 20.0,
                                )));
                      }),
                ),
              ),
            ],
          );
  }
}

class MinbarBar extends StatelessWidget {
  final MiddleController middleController = MiddleController();
  final int selectedIndex;
  final List<NavigatonItem> items;
  final NavgationController? navigationController;

  MinbarBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    this.navigationController,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        NavigationBar(
            selectedIndex: selectedIndex,
            items: items,
            middleController: middleController),
        Consumer<CastService>(builder: (context, state, child) {
          print([1, state.currentCast]);
          if (state.currentCast == null)
            middleController.normal();
          else
            middleController.outside();

          return ActionButton(state: state, middleController: middleController);
        })
      ],
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