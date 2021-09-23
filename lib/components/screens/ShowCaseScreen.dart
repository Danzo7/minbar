import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/staticValues.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:minbar_fl/components/widgets/post/post.dart';

class ShowCaseScreen extends StatelessWidget {
  final component;
  const ShowCaseScreen({Key? key, this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          padding: EdgeInsets.all(10),
          child: const SpacedScrollView(
            spacing: 10,
            children: const [Post()],
          ),
          alignment: Alignment.center,
        ),
        bottomNavigationBar: StaticValues.navBar);
  }
}
