import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'widgets/comments_section_bs.dart';

class BroadcastPage extends StatelessWidget {
  const BroadcastPage(
      {Key? key, this.controller, this.height, this.dragController})
      : super(key: key);
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: const AssetImage('assets/images/cover.png'),
            )),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                GestureDetector(
                  onVerticalDragUpdate: dragController?.dragUpdate,
                  onVerticalDragEnd: dragController?.dragEnd,
                  onTap: () => controller!.isExpanded
                      ? controller?.show()
                      : controller?.expand(),
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
                ),
                headerInfo(context),
                content(),
              ],
            ),
          ),
          CommentSection(),
        ],
      ),
    );
  }

  Wrap content() {
    return Wrap(
      spacing: 10,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        NotAButton(
          child: Text("درس", style: DTextStyle.w18),
          backgroundColor: DColors.orange,
          raduis: 7,
          spacing: 5,
        ),
        AutoSizeText("سوء الضن",
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
              "راشد الشافعي",
              style: DTextStyle.w18,
            ),
            IconButton(
              onPressed: () => {print("owww")},
              icon: Icon(
                SodaIcons.heart,
                color: DColors.sadRed,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: DColors.green),
          child: Wrap(
            spacing: 12,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconBuilder("deafen"),
              Text(
                "01:09:15",
                style: DTextStyle.w18.copyWith(fontSize: 17),
              ),
              IconBuilder("recording")
            ],
          ),
        )
      ],
    );
  }

  Row headerInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              SodaIcons.close,
              color: DColors.white,
            ),
            onPressed: () => {controller?.close()},
          ),
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
    );
  }
}

class RoundedLine extends StatelessWidget {
  const RoundedLine({
    Key? key,
    this.thikness = 1,
    this.width = 20,
    this.color = Colors.white,
  }) : super(key: key);
  final double width, thikness;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(thikness * 100)),
      height: thikness,
      constraints: BoxConstraints(maxHeight: thikness),
      width: width,
    );
  }
}
