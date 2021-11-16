import 'package:flutter/material.dart';
import 'package:minbar_fl/model/comment_data.dart';

import 'comment.dart';

class CommentList extends StatelessWidget {
  final List<CommentData> comments;
  const CommentList(this.comments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Comment(comments[index])),
      childCount: comments.length,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
    ));
  }
}
