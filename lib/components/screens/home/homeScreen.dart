import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavType navType = NavType.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            color: DColors.blueGray,
            value: "Change Menu Type...",
            onClick: () => setState(() => {
                  navType = navType == NavType.broadcastable
                      ? NavType.listen
                      : NavType.broadcastable
                }),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(navType: navType),
    );
  }
}
