import 'package:flutter/material.dart';
import 'package:minbar_fl/components/common/post/widgets/post.dart';
import 'package:minbar_fl/model/publication.dart';

class PostList extends StatelessWidget {
  final List<Publication> items;
  const PostList(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(right: 15, left: 15, top: 10),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Post(items[index])),
          childCount: items.length,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
        )));
  }
}
