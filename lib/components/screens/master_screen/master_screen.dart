import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({Key? key}) : super(key: key);

  final MinbarBottomSheetController controller =
      MinbarBottomSheetController(isInstance: true);
  final NavgationController navgationController = NavgationController();
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (MinbarBottomSheetInstances.mayPop())
          return false;
        else if (navgationController.mayPop())
          return false;
        else {
          final differeance = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differeance >= Duration(seconds: 2)) {
            final String msg = 'اضغط مرة اخرى للخروج';
            Fluttertoast.showToast(
              msg: msg,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            SystemNavigator.pop();
            return true;
          }
        }
      },
      child: MinbarScaffold(
          bottomSheet: BroadcastBottomSheet(controller: controller),
          floatingActionButton: startBroadcasting(controller),
          hasDrawer: true,
          body: PageNavigation(
              navgationController: navgationController,
              slidable: true,
              pages: {
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
            backgroundColor: minbarTheme.primary,
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
                  style: DTextStyle.w12,
                  blankSpace: 50,
                  velocity: 20.0,
                )),
            Divider(
              color: minbarTheme.onPrimary,
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
          backgroundColor: minbarTheme.actionHot),
    );
  }
}
