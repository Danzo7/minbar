import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/avatar.dart';
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(
                data.user.avatarUrl,
                raduis: 21,
                borderColor: DColors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: minbarTheme.secondaryVariant,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    data.content,
                    style: DTextStyle.w12,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.bottomLeft,
            child: Text(
              '10:11',
              style: DTextStyle.w8.copyWith(color: DColors.coldGray),
            ),
          )
        ],
      ),
    );
  }
}
