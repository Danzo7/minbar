import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:minbar_fl/components/screens/broadcast/broadcast_bottom_sheet.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_colors.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/components/widgets/text_play.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'pages/pages.dart';
export 'pages/pages.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({Key? key}) : super(key: key);
  final MinbarBottomSheetController controller =
      MinbarBottomSheetController(isInstance: true);
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (MinbarBottomSheetInstances.mayPop())
          return false;
        else {
          return false;
        }
      },
      child: MinbarScaffold(
          bottomSheet: BroadcastBottomSheet(controller: controller),
          floatingActionButton: startBroadcasting(controller),
          hasDrawer: true,
          body: PageNavigation(pages: {
            BroadcastsPage.route: BroadcastsPage(),
            HomePage.route: HomePage(),
            ProfilePage.route: ProfilePage(),
            SettingsScreen.route: SettingsScreen(),
          })),
    );
  }

  Container currentlyListeningField() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 30),
      child: Wrap(
        children: [
          FlatIconButton(
            backgroundColor: DColors.blueGray,
            icon: Icon(SodaIcons.listening, size: 24, color: DColors.white),
            onTap: () => {},
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextPlay(
                textAlign: TextAlign.center,
                minFontSize: 10,
                marquee: Marquee(
                  showFadingOnlyWhenScrolling: true,
                  fadingEdgeEndFraction: 0.1,
                  text: "سوء الضنا الضنا الضنا",
                  style: TextStyle(color: DColors.white, fontSize: 12),
                  blankSpace: 50,
                  velocity: 20.0,
                )),
            Divider(
              color: DColors.white,
              thickness: 2,
            )
          ])
        ],
      ),
    );
  }

  Widget startBroadcasting(MinbarBottomSheetController controller) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: FlatIconButton(
          onTap: () => controller.show(),
          icon: Icon(SodaIcons.broadcast, size: 24, color: DColors.white),
          backgroundColor: DColors.sadRed),
    );
  }
}
