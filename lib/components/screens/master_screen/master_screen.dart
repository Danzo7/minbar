import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/broadcast/Broadcast_page.dart';
import 'package:minbar_fl/components/theme/default_colors.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

import 'pages/pages.dart';
export 'pages/pages.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: PageNavigation(pages: {
            BroadcastsPage.route: BroadcastsPage(),
            HomePage.route: HomePage(),
            ProfilePage.route: ProfilePage(),
            SettingsScreen.route: SettingsScreen(),
          }),
        ),
      ],
    );
  }
}
