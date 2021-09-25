import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/staticValues.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';

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
            children: [Post()],
          ),
          alignment: Alignment.center,
        ),
        bottomNavigationBar: StaticValues.navBar);
  }
}
