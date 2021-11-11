import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class CommentField extends StatefulWidget {
  final TextEditingController controller;

  final onSubmit;

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
      if (mounted && (widget.controller.value.text.length > 0) && !isTyping)
        setState(() {
          isTyping = true;
        });
      else if (widget.controller.text.length == 0)
        setState(() {
          isTyping = false;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 35;
    final min = (width * 60) / 70;
    final max = (width * 70) / 70;

    return Container(
        color: minbarTheme.primary,
        child: OverflowBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 90),
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
                      fillColor: minbarTheme.primaryVariant,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                            BorderSide(color: minbarTheme.primaryVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                            BorderSide(color: minbarTheme.primaryVariant),
                      ),
                      suffixIcon: !isTyping
                          ? FlatIconButton(
                              size: 40,
                              onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (_) => Container(
                                        height: 100,
                                        color: DColors.brown,
                                      )),
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
                duration: Duration(milliseconds: 90),
                width: isTyping ? 48 : 0,
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
