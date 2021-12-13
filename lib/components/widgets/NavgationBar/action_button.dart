import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/middle_controller.dart';
import 'package:minbar_fl/components/widgets/floating_widget.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/voice_visualisation.dart';
import 'package:minbar_fl/core/services/audio_service.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';

class ActionButton extends StatefulWidget {
  ActionButton({
    Key? key,
    required this.state,
    required this.middleController,
  }) : super(key: key);

  final MiddleController middleController;
  final CastService? state;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    bool isSwipeUp = false;
    void action() => showBroadcastBottomSheet(
          context,
        );
    return (widget.state == null || widget.state?.currentCast == null)
        ? SizedBox()
        : FloatingWidget(
            onDragCanceled: () {
              widget.middleController.inside();
            },
            withHitDetection: true,
            padding: EdgeInsets.only(bottom: 30),
            snaps: [
              SnapLocation(
                  pos: Offset(-0, -100),
                  radius: 50,
                  onSnap: () async => await widget.state!.pauseOrStop()
                      ? null
                      : widget.middleController.outside(),
                  snapLocator: ClipOval(
                      child: Container(
                    color: DColors.sadRed,
                    height: 70,
                    width: 70,
                    child: Center(
                        child: Icon(
                      Icons.stop_rounded,
                    )),
                  ))),
              HitSnapLocation(
                pos: Offset.zero,
                radius: 50,
                onHitChange: (bool isIn) => isIn
                    ? widget.middleController.outside()
                    : widget.middleController.normal(),
              )
            ],
            child: GestureDetector(
              onVerticalDragUpdate: (details) =>
                  isSwipeUp = details.delta.dy < 0 ? true : false,
              onVerticalDragEnd: (c) => {if (isSwipeUp) action()},
              child: StreamBuilder<PlayerState>(
                  stream: app<AudioService>().playerStateStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<PlayerState> snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;

                    return FlatIconButton(
                        backgroundColor: minbarTheme.secondary,
                        icon: (processingState == ProcessingState.ready &&
                                app<AudioService>().playerState.playing)
                            ? VoiceVisualisation()
                            : (processingState == ProcessingState.buffering ||
                                    processingState == ProcessingState.loading)
                                ? CircularProgressIndicator()
                                : Icon(
                                    Icons.pause,
                                    color: DColors.white,
                                  ),
                        onTap: action);
                  }),
            ),
          );
  }
}
