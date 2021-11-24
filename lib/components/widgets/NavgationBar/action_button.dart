import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/text_play.dart';
import 'package:minbar_fl/core/services/audio_service.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import '../voice_visualisation.dart';
import 'middle_controller.dart';

class ActionButton extends StatefulWidget {
  final MiddleController middleController;

  ActionButton({
    Key? key,
    required this.state,
    required this.middleController,
  }) : super(key: key);
  final CastService? state;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  var isOverlay = false;
  void showOverlay() => setState(() {
        isOverlay = true;
      });
  void hideOverlay() => setState(() {
        isOverlay = false;
      });
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
        feedback: child,
        onDragStarted: () {
          widget.middleController.normal();
          showOverlay();
        },
        onDragEnd: (details) {
          if (MediaQuery.of(context).size.height - 150 > details.offset.dy) {
            if (onDragComplete != null) onDragComplete();
          } else {
            widget.middleController.outside();
          }
          hideOverlay();
        },
        onDragUpdate: (details) {},
        childWhenDragging: SizedBox(),
      );
    }

    return (widget.state == null || widget.state?.currentCast == null)
        ? SizedBox()
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              isOverlay
                  ? Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Center(
                                child: ClipOval(
                                    child: Container(
                                  color: DColors.sadRed,
                                  height: 70,
                                  width: 70,
                                  child:
                                      Center(child: Icon(Icons.stop_rounded)),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
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

                        return dragablebubble(
                            onDragComplete: widget.state!.stopCast,
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
                                  text: widget.state!.currentCast!.subject,
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
