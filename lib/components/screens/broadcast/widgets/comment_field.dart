import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class CommentField extends StatelessWidget {
  final TextEditingController controller;

  final onSubmit;

  const CommentField(
      {Key? key, required this.controller, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: DColors.blueGray,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                style: DTextStyle.w12,
                maxLines: 3,
                minLines: 1,
                maxLength: 50,
                decoration: InputDecoration(
                    hintText: "تعليق",
                    hintStyle: DTextStyle.w12,
                    filled: true,
                    fillColor: DColors.blueSaidGray,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(color: DColors.blueSaidGray),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(color: DColors.blueSaidGray),
                    ),
                    contentPadding: const EdgeInsets.all(10)),
              ),
            ),
            FlatIconButton(
              onTap: onSubmit,
              icon: Icon(
                Icons.send,
                color: DColors.white,
              ),
              size: 50,
            ),
          ],
        ));
  }
}
