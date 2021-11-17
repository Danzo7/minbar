import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/voice_visualisation.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';

import 'package:minbar_fl/model/cast.dart';

import '../../../../widgets/buttons/buttons.dart';

class BroadcastBox extends StatefulWidget {
  const BroadcastBox(this.cast, {Key? key}) : super(key: key);

  final Cast cast;

  @override
  State<BroadcastBox> createState() => _BroadcastBoxState();
}

class _BroadcastBoxState extends State<BroadcastBox> {
  @override
  void initState() {
    app<CastService>().addListener(listener);
    super.initState();
  }

  void listener() => {
        if (mounted && app<CastService>().currentCast == widget.cast)
          setState(() {})
      };
  @override
  void dispose() {
    app<CastService>().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/cover.png'),
              fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(17)),
      child: Container(
        width: double.infinity,
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: app<CastService>().currentCast == widget.cast
                  ? StreamBuilder<PlayerState>(
                      stream: app<AudioService>().playerStateStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<PlayerState> snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        print(processingState);
                        if (processingState == ProcessingState.loading) {
                          return CircularProgressIndicator();
                        } else if (processingState == ProcessingState.ready &&
                            app<AudioService>().playerState.playing)
                          return FlatIconButton(
                            icon: VoiceVisualisation(),
                            onTap: () =>
                                app<CastService>().playCast(widget.cast),
                          );
                        else
                          return playButton();
                      },
                    )
                  : playButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Column(
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
                          widget.cast.hostUsername,
                          style: DTextStyle.w12,
                          minFontSize: 8,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                          spacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text(
                              widget.cast.views.toString(),
                              style: DTextStyle.w12,
                              textAlign: TextAlign.center,
                            ),
                            const Icon(
                              SodaIcons.listeners,
                              size: 15,
                              color: Colors.white,
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RawMaterialButton playButton() {
    return RawMaterialButton(
      onPressed: () => app<CastService>().playCast(widget.cast),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            alignment: Alignment.bottomLeft,
            child: Icon(SodaIcons.pause, size: 35, color: Colors.white)),
      ),
    );
  }
}
