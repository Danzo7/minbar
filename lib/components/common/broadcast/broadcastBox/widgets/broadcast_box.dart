import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/voice_visualisation.dart';
import 'package:minbar_fl/core/services/audio_service.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/model/cast.dart';
import 'package:provider/provider.dart';

class BroadcastBox extends StatefulWidget {
  final bool withDetail;
  final double height;
  const BroadcastBox(this.cast,
      {Key? key, this.withDetail = true, this.height = 120})
      : super(key: key);

  final Cast cast;

  @override
  State<BroadcastBox> createState() => _BroadcastBoxState();
}

class _BroadcastBoxState extends State<BroadcastBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CastService>(
      builder: (context, state, child) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage('assets/images/cover.png'),
                  fit: BoxFit.fitWidth),
              borderRadius: BorderRadius.circular(17)),
          child: Container(
            width: double.infinity,
            height: widget.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.withDetail)
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: details(),
                        ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: listeners(state.currentCast == widget.cast),
                      )
                    ],
                  ),
                ),
                Container(
                  child: state.currentCast == widget.cast
                      ? StreamBuilder<PlayerState>(
                          stream: app<AudioService>().playerStateStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<PlayerState> snapshot) {
                            final playerState = snapshot.data;
                            final processingState =
                                playerState?.processingState;
                            if (processingState == ProcessingState.loading) {
                              return CircularProgressIndicator();
                            } else if (processingState ==
                                    ProcessingState.ready &&
                                app<AudioService>().playerState.playing) {
                              return FlatIconButton(
                                icon: VoiceVisualisation(),
                                onTap: () => state.playCast(widget.cast),
                              );
                            } else {
                              return playButton(state);
                            }
                          },
                        )
                      : playButton(state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column details() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NotAButton(
          child: Text(widget.cast.field, style: DTextStyle.w10),
          backgroundColor: DColors.orange,
          raduis: 7,
          spacing: 5,
        ),
        AutoSizeText(
          widget.cast.subject,
          style: DTextStyle.w20s,
          minFontSize: 12,
          maxLines: 1,
        ),
        AutoSizeText(
          widget.cast.host.fullName,
          style: DTextStyle.w12,
          minFontSize: 8,
          maxLines: 1,
          overflow: TextOverflow.visible,
        )
      ],
    );
  }

  Container listeners(bool bool) {
    return Container(
      alignment: Alignment.topLeft,
      child: Wrap(
          spacing: 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          verticalDirection: VerticalDirection.up,
          children: [
            Text(
              (widget.cast.listeners + (bool ? 1 : 0)).toString(),
              style: DTextStyle.w12,
              textAlign: TextAlign.center,
            ),
            const Icon(
              SodaIcons.listeners,
              size: 15,
              color: Colors.white,
            )
          ]),
    );
  }

  RawMaterialButton playButton(state) {
    return RawMaterialButton(
      onPressed: () => state.playCast(widget.cast),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            alignment:
                widget.withDetail ? Alignment.bottomLeft : Alignment.center,
            child: Icon(SodaIcons.pause, size: 35, color: Colors.white)),
      ),
    );
  }
}
