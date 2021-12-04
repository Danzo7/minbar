import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minbar_fl/components/common/post/widgets/post.dart';

import 'package:minbar_fl/components/common/timelines/posts_timeline/bloc/posts_bloc.dart';
import 'package:minbar_fl/components/widgets/post_placeholder.dart';
import 'package:minbar_fl/model/publication.dart';

class PostList extends StatelessWidget {
  final Widget? title;
  const PostList({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildList(context.read<PostsBloc>().repo.data);
      },
    );
  }

  Widget buildList(List<Publication> items) {
    return SliverPadding(
        padding: EdgeInsets.only(right: 15, left: 15, top: 10),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => index == 0
                    ? Center(child: title)
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: items.isNotEmpty
                            ? Post(items[index])
                            : PostPlaceholder()),
                childCount: items.length + (items.isEmpty ? 2 : 0),
                addAutomaticKeepAlives: false)));
  }
}
