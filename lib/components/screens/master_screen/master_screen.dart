export 'profile/profile_screen.dart';
export 'live_broadcasts/live_broadcasts_screen.dart';
export 'home/home_screen.dart';
export 'settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/master_screen/home/home_screen.dart';
import 'package:minbar_fl/components/screens/master_screen/profile/profile_screen.dart';
import 'package:minbar_fl/components/screens/master_screen/settings/settings_screen.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  PageController _controller = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MinbarScaffold(
      selectedIndex: 0,
      withSafeArea: true,
      hasBottomNavigationBar: true,
      pageController: _controller,
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LiveBroadcastsScreen(),
          HomeScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
