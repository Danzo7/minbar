import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_colors.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';
import 'package:minbar_fl/core/services/cast_service.dart';

import 'package:minbar_fl/misc/page_navigation.dart';
import 'pages/pages.dart';
export 'pages/pages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({Key? key}) : super(key: key);

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
      child: ChangeNotifierProvider(
        create: (context) => CastService(),
        child: MinbarScaffold(
            hasBottomNavigationBar: true,
            navgationController: navgationController,
            body: PageNavigation(
                navgationController: navgationController,
                slidable: true,
                pages: {
                  BroadcastsPage.route: BroadcastsPage(),
                  HomePage.route: HomePage(),
                  ProfilePage.route: ProfilePage(),
                  SettingsScreen.route: SettingsScreen(),
                  // "crash": CrashPO()
                })),
      ),
    );
  }

  Widget startBroadcasting(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 200),
      child: FlatIconButton(
          onTap: () {},
          icon: Icon(SodaIcons.broadcast, size: 24, color: DColors.white),
          backgroundColor: minbarTheme.actionHot),
    );
  }
}
