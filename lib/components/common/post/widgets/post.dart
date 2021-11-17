import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/common/post/widgets/reaction_bar.dart';
import 'package:minbar_fl/model/publication.dart';

import 'content.dart';
import 'header.dart';
import 'podcast_box.dart';

class Post extends StatelessWidget {
  final Publication pub;
  const Post(this.pub, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: DColors.coldGray)),
      child: Wrap(
        spacing: 3,
        children: [
          //header
          Header(pub),
          //content
          Content(value: pub.content),
          //resource
          if (pub.hasPodcast) PodcastBox(),
          //ReactionBar
          ReactionBar(heartCount: pub.likeCount, pinCount: pub.pinCount)
        ],
      ),
    );
  }
}
