import 'package:flutter/material.dart';
import 'package:minbar_fl/api/fake_data.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/common/post/widgets/reaction_bar.dart';
import 'package:minbar_fl/components/widgets/image_loader.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:shimmer/shimmer.dart';

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
          if (pub.hasCast)
            //get cast somehow
            PodcastBox(
              cast: FakeData.casts[1],
            ),
          if (pub.hasMedia)
            ImageLoader(
                height: 200,
                width: double.infinity,
                imageUrl: '',
                fit: BoxFit.fitWidth),
          //ReactionBar
          ReactionBar(
            pub: pub,
          )
        ],
      ),
    );
  }
}
