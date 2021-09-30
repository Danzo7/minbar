import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/post/podcast_box.dart';
import 'package:minbar_fl/components/widgets/post/content.dart';
import 'package:minbar_fl/components/widgets/post/Header.dart';
import 'package:minbar_fl/components/widgets/post/reaction_bar.dart';
import 'package:minbar_fl/model/publication.dart';

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
          Header(
            username: pub.authorName,
            field: pub.type,
            verb: "قام ببث",
            withDetail: pub.type != "",
            avatarPath: pub.authorAvatar,
            timestamp: pub.timestamp,
          ),
          //content
          Content(value: pub.content),
          //resource
          if (pub.hasPodcast) PodcastBox(),
          //ReactionBar
          ReactionBar(likeAmount: pub.likeCount, pinsAmount: pub.pinCount)
        ],
      ),
    );
  }
}
