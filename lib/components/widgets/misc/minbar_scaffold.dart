import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/master_screen/settings/settings_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';

class MinbarScaffold extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final bool withSafeArea;
  final bool hasBottomNavigationBar;
  final bool hasDrawer;
  final PageController? pageController;
  const MinbarScaffold(
      {Key? key,
      this.selectedIndex = 0,
      required this.body,
      this.withSafeArea = true,
      this.hasBottomNavigationBar = false,
      this.hasDrawer = true,
      this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hasDrawer ? SettingsLayout() : null,
      backgroundColor: DColors.white,
      extendBody: true,
      bottomNavigationBar: (hasBottomNavigationBar)
          ? NavigationBar(
              selectedIndex: selectedIndex,
              type: NavType.broadcastable,
              items: navigationItems,
              pageController: pageController)
          : null,
      body: withSafeArea ? SafeArea(bottom: false, child: body) : body,
    );
  }
}
