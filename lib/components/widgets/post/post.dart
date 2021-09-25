import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/post/Content.dart';
import 'package:minbar_fl/components/widgets/post/Header.dart';
import 'package:minbar_fl/components/widgets/post/ReactionBar.dart';
import 'package:minbar_fl/model/publication.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Publication pub = Publication(
        id: "12334",
        content:
            "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق",
        type: "حوار",
        date: DateTime(2021, 9, 24, 23, 40),
        likeCount: 24,
        pinCount: 5,
        hasPodcast: false,
        authorAvatar: "assets/images/profilePicture.png",
        authorName: "مسيلمة الكذاب");
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
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
          Container(),
          //ReactionBar
          ReactionBar(likeAmount: pub.likeCount, pinsAmount: pub.pinCount)
        ],
      ),
    );
  }
}
