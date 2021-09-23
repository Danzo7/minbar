import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/post/Content.dart';
import 'package:minbar_fl/components/widgets/post/Header.dart';
import 'package:minbar_fl/components/widgets/post/ReactionBar.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            username: "مسيلمة الكذاب",
            field: "حوار",
            verb: "قام ببث",
            withDetail: true,
            avatarPath: "assets/images/profilePicture.png",
            timeAgo: "قبل 24 ساعة",
          ),
          //content
          Content(
              value:
                  "نظل سنوات ندعو على الظالمين والمتكبرين  ومجرد أن نرى في أحدهم شيئا لا نستطيع الشماتة او التشفي ونوصي بعضنا بعضا قائلين - ارحموا عزيز قوم ذل لا عجب إذن أننا أُمة مرحومة. قلوبها كأفئدة الطير بحق"),
          //resource
          Container(),
          //ReactionBar
          ReactionBar(likeAmount: 15, pinsAmount: 24)
        ],
      ),
    );
  }
}
