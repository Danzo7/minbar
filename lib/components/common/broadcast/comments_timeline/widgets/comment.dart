import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/model/comment_data.dart';

class Comment extends StatelessWidget {
  final CommentData data;
  const Comment(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: minbarTheme.secondaryVariant,
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        data.content,
        style: DTextStyle.w12,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
