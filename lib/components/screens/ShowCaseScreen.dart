import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/staticValues.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';
import 'package:minbar_fl/model/publication.dart';

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

class ShowCaseScreen extends StatelessWidget {
  final component;
  const ShowCaseScreen({Key? key, this.component}) : super(key: key);
  List<Widget> get createListTiles {
    List<Widget> tiles = <Widget>[];
    for (int i = 0; i < 40; i++) {
      int count = i + 1;
      tiles.add(new ListTile(
        leading: new CircleAvatar(
          child: new Text("$count"),
          backgroundColor: Colors.lightGreen[700],
        ),
        title: new Text("Title number $count"),
        subtitle: new Text("This is the subtitle number $count"),
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SpacedScrollView(
            spacing: 10,
            children: [
              Post(pub),
              Post(pub),
              Post(pub),
              Post(pub),
              Post(pub),
              Post(pub),
            ],
          ),
          alignment: Alignment.center,
        ),
        bottomNavigationBar: StaticValues.navBar);
  }
}
