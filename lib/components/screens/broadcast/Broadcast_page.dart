import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:minbar_fl/components/screens/master_screen/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';

class BroadcastPage extends StatelessWidget {
  const BroadcastPage({Key? key, this.controller, this.height})
      : super(key: key);
  final double? height;
  final MinbarBottomSheetController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
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

  Row headerInfo() {
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

class Comment extends StatelessWidget {
  final String text;
  const Comment(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: DColors.sadRed, borderRadius: BorderRadius.circular(15)),
      child: Text(text, style: DTextStyle.w12),
    );
  }
}

class CommentSection extends StatelessWidget {
  const CommentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    final MinbarBottomSheetController panelController =
        MinbarBottomSheetController();
    final DragController dragController = DragController();
    return Container(
        child: MinbarBottomSheet(
      controller: panelController,
      dragController: dragController,
      collapseHeight: 120,
      closeWhenLoseFocus: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: DColors.blueGray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7))),
                height: 50,
                width: 40,
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
                    ),
                  ],
                ),
              )),
          Container(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                  height: 250,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 10),
                  decoration: BoxDecoration(
                      color: DColors.blueGray,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7))),
                  child: Wrap(runSpacing: 10, children: [
                    Comment("العرب"),
                    AutoSizeTextField(
                      controller: _textEditingController,
                      style: DTextStyle.w12,
                      maxLines: 4,
                      minLines: 1,
                      maxLength: 152,
                      decoration: InputDecoration(
                          hintText: "تعليق",
                          hintStyle: DTextStyle.w12,
                          filled: true,
                          fillColor: DColors.blueSaidGray,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                const BorderSide(color: DColors.blueSaidGray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                const BorderSide(color: DColors.blueSaidGray),
                          ),
                          contentPadding: const EdgeInsets.all(10)),
                    )
                  ])),
            ),
          ),
        ],
      ),
    ));
  }
}
