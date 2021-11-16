import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/widgets/rounder_line.dart';
import 'package:minbar_fl/core/services/AudioService.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/core/services/service_locator.dart';
import 'package:minbar_fl/model/cast.dart';
import 'widgets/comments_section_bs.dart';

class BroadcastScreen extends StatelessWidget {
  final bool hasComments;
  final Cast cast = app<CastService>().currentCast!;
  BroadcastScreen({
    Key? key,
    this.controller,
    this.height,
    this.dragController,
    this.hasComments = false,
  }) : super(key: key);
  final double? height;
  final MinbarBottomSheetController? controller;
  final DragController? dragController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width
                  ? BoxFit.fitHeight
                  : BoxFit.fitWidth,
              image: const AssetImage('assets/images/cover.png'),
            )),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                drager(context),
                headerInfo(context),
                content(),
              ],
            ),
          ),
          if (hasComments) CommentSection(),
        ],
      ),
    );
  }

  GestureDetector drager(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: dragController?.dragUpdate,
      onVerticalDragEnd: dragController?.dragEnd,
      onTap: controller != null
          ? () =>
              controller!.isExpanded ? controller?.show() : controller?.expand()
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedLine(
              thikness: 5,
              width: MediaQuery.of(context).size.width / 3,
            )
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Wrap(
      spacing: 10,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        NotAButton(
          child: Text(cast.field, style: DTextStyle.w18),
          backgroundColor: minbarTheme.actionWarm,
          raduis: 7,
          spacing: 5,
        ),
        AutoSizeText(cast.subject,
            maxFontSize: 36, minFontSize: 12, style: DTextStyle.w36s),
        ClipOval(
            child: Container(
                height: 105,
                width: 110,
                child: Image.asset(
                  "assets/images/profilePicture.png",
                  fit: BoxFit.fitWidth,
                ))),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Text(
              cast.hostUsername,
              style: DTextStyle.w18,
            ),
            FlatIconButton(
              onTap: () => {},
              icon: Icon(
                SodaIcons.heart,
                color: minbarTheme.actionHot,
              ),
            ),
          ],
        ),
        Player(
          player: app<AudioService>().player,
        ),
      ],
    );
  }

  headerInfo(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatIconButton(
            size: 40,
            icon: Icon(
              SodaIcons.close,
              color: DColors.white,
            ),
            onTap: () => {controller?.close()},
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              Text("1.3k", style: DTextStyle.w15s),
              Icon(
                SodaIcons.listeners,
                size: 20,
                color: DColors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Player extends StatefulWidget {
  final AudioPlayer player;

  const Player({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: minbarTheme.actionCold),
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(onPressed: () => {}, icon: IconBuilder("deafen")),
          StreamBuilder<BroadcastPositionData>(
              stream: app<AudioService>().broadcastPositionData,
              builder: (context, snapshot) {
                return Text(
                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                          .firstMatch("${snapshot.data?.position}")
                          ?.group(1) ??
                      '${snapshot.data?.position}',
                  style: DTextStyle.w18.copyWith(fontSize: 17),
                );
              }),
          IconBuilder("recording")
        ],
      ),
    );
  }
}
