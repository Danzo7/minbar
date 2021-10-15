import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/master_screen/pages/settings/settings_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';

class MinbarScaffold extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final bool withSafeArea;
  final bool hasBottomNavigationBar;
  final Widget? navigationBar;
  final bool hasDrawer;
  const MinbarScaffold(
      {Key? key,
      this.selectedIndex = 0,
      required this.body,
      this.withSafeArea = true,
      this.hasBottomNavigationBar = false,
      this.hasDrawer = true,
      this.navigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hasDrawer ? SettingsLayout() : null,
      backgroundColor: DColors.white,
      extendBody: true,
      bottomNavigationBar: navigationBar ??
          ((hasBottomNavigationBar)
              ? NavigationBar(
                  selectedIndex: selectedIndex,
                  type: NavType.broadcastable,
                  items: navigationItems,
                )
              : null),
      body: withSafeArea ? SafeArea(bottom: false, child: body) : body,
    );
  }
}
