import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/screens.dart';
import 'package:minbar_fl/components/screens/settings/setting_data_presentation.dart';
import 'package:minbar_fl/components/screens/settings/widgets/settings_tree.dart';
import 'package:minbar_fl/components/screens/settings/widgets/tree_leaf.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';

class MinbarScaffold extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final bool withSafeArea;
  final bool hasBottomNavigationBar;
  final bool hasDrawer;
  const MinbarScaffold(
      {Key? key,
      this.selectedIndex = 0,
      required this.body,
      this.withSafeArea = true,
      this.hasBottomNavigationBar = true,
      this.hasDrawer = true})
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
            )
          : null,
      body: withSafeArea ? SafeArea(bottom: false, child: body) : body,
    );
  }
}
