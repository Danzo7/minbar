import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/rounder_line.dart';

class CommentField extends StatefulWidget {
  final TextEditingController controller;

  final void Function()? onSubmit;

  const CommentField(
      {Key? key, required this.controller, required this.onSubmit})
      : super(key: key);

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  bool isTyping = false;
  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted && (widget.controller.value.text.isNotEmpty) && !isTyping) {
        setState(() {
          isTyping = true;
        });
      } else if (widget.controller.text.isEmpty) {
        setState(() {
          isTyping = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 35;
    final min = (width * 59) / 70;
    final rest = (width * 10) / 70;
    final max = (width * 70) / 70;

    return Container(
        color: minbarTheme.secondary,
        child: OverflowBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: kFastAnimationDuration,
                width: isTyping ? min : max,
                child: TextFormField(
                  controller: widget.controller,
                  style: DTextStyle.w12,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 50,
                  buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                      hintText: "تعليق",
                      hintStyle: DTextStyle.w12,
                      filled: true,
                      fillColor: minbarTheme.secondaryVariant,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                            BorderSide(color: minbarTheme.secondaryVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                            BorderSide(color: minbarTheme.secondaryVariant),
                      ),
                      suffixIcon: !isTyping
                          ? FlatIconButton(
                              size: 40,
                              onTap: () => showMinbarBottomSheet(context,
                                  child: Container(
                                      alignment: Alignment.center,
                                      color: DColors.blueGray,
                                      height: 100,
                                      width: 100,
                                      child: ListTile(
                                        tileColor: DColors.green,
                                        title: Row(
                                          children: [
                                            RoundedLine(
                                              thikness: 30,
                                              width: 2,
                                            ),
                                          ],
                                        ),
                                      ))),
                              icon: Icon(
                                SodaIcons.pray,
                                color: DColors.white,
                              ),
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
                ),
              ),
              AnimatedContainer(
                duration: kFastAnimationDuration,
                width: isTyping ? rest : 0,
                height: isTyping ? 48 : 0,
                child: isTyping
                    ? FlatIconButton(
                        backgroundColor: DColors.blueSaidGray,
                        onTap: widget.onSubmit,
                        icon: Icon(
                          Icons.send_rounded,
                          color: DColors.white,
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ));
  }
}
