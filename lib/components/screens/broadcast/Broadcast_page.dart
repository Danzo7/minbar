import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';

class BroadcastPage extends StatelessWidget {
  const BroadcastPage(this.height, {Key? key}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(30),
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
                headerInfo(),
                Wrap(
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
                        maxFontSize: 36,
                        minFontSize: 12,
                        style: DTextStyle.w36s),
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
                        Icon(
                          SodaIcons.heart,
                          color: DColors.sadRed,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: DColors.green),
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
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: DColors.blueGray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                height: 42,
                width: 41,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconBuilder(
                      "comment",
                      fit: BoxFit.scaleDown,
                    ),
                    Icon(
                      SodaIcons.arrowUp,
                      size: 10,
                      color: DColors.white,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Row headerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Icon(
            SodaIcons.close,
            color: DColors.white,
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
