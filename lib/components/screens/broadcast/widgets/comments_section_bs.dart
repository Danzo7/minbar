import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/icon_builder.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';

class CommentSection extends StatelessWidget {
  const CommentSection(
      {Key? key, MinbarBottomSheetController? parentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    final MinbarBottomSheetController commentSheetController =
        MinbarBottomSheetController(isInstance: true);
    return Container(
        child: MinbarBottomSheet(
      controller: commentSheetController,
      collapseHeight: 90,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ShowCommentsButton(commentSheetController: commentSheetController),
          Container(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
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

class _ShowCommentsButton extends StatefulWidget {
  const _ShowCommentsButton({
    Key? key,
    required this.commentSheetController,
  }) : super(key: key);

  final MinbarBottomSheetController commentSheetController;

  @override
  State<_ShowCommentsButton> createState() => _ShowCommentsButtonState();
}

class _ShowCommentsButtonState extends State<_ShowCommentsButton> {
  bool arrowDirUp = true;
  @override
  void initState() {
    widget.commentSheetController.addListener(() => setState(() {
          arrowDirUp = widget.commentSheetController.isClosed;
        }));
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.commentSheetController.isClosed
            ? widget.commentSheetController.show
            : widget.commentSheetController.close,
        child: Container(
            decoration: BoxDecoration(
                color: DColors.blueGray,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7))),
            height: 40,
            width: 40,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconBuilder(
                "comment",
                fit: BoxFit.scaleDown,
              ),
              Icon(
                arrowDirUp ? SodaIcons.arrowUp : SodaIcons.arrowDown,
                size: 10,
                color: DColors.white,
              ),
            ])));
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
