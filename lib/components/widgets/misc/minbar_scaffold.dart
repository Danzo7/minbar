import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/master_screen/pages/settings/settings_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

class MinbarScaffold extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final bool withSafeArea;
  final bool hasBottomNavigationBar;
  final Widget? navigationBar;
  final bool hasDrawer;
  final List<Widget>? persistentFooterButtons;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final bool resizeToAvoidBottomInset;
  final NavgationController? navgationController;

  final Color? backgroundColor;

  const MinbarScaffold(
      {Key? key,
      this.selectedIndex = 0,
      required this.body,
      this.withSafeArea = true,
      this.hasBottomNavigationBar = false,
      this.hasDrawer = false,
      this.navigationBar,
      this.resizeToAvoidBottomInset = true,
      this.persistentFooterButtons,
      this.floatingActionButton,
      this.bottomSheet,
      this.navgationController,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _body = bottomSheet != null || floatingActionButton != null
        ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            body,
            if (floatingActionButton != null) floatingActionButton as Widget,
            if (bottomSheet != null) bottomSheet as Widget,
          ])
        : body;

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      drawer: hasDrawer ? SettingsLayout() : null,
      backgroundColor: backgroundColor ?? DColors.white,
      extendBody: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: navigationBar ??
          ((hasBottomNavigationBar)
              ? NavigationBar(
                  selectedIndex: selectedIndex,
                  type: NavType.broadcastable,
                  items: navigationItems,
                  navigationController: navgationController,
                )
              : null),
      body: withSafeArea ? SafeArea(bottom: false, child: _body) : _body,
    );
  }
}
