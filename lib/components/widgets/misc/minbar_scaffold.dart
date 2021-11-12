import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/master_screen/pages/settings/settings_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'package:minbar_fl/misc/page_navigation.dart';

MinbarBottomSheetController showMinbarBottomSheet(
  BuildContext context, {
  double elevation = 1,
  required Widget child,
  double? minHeight,
  double? maxHeight,
  double radiusWhenNotExpanded = 0,
  bool slideToExpand = true,
  bool allowSlideInExpanded = true,
  bool closeWhenLoseFocus = true,
  double collapseHeight = 0,
  dragController,
  bool constraint = false,
  bool snapToExpand = true,
  double? minFraction,
  double? maxFraction,
  bool isTranslucent = false,
}) {
  MinbarBottomSheetController controller = MinbarBottomSheetController(
      isInstance: true, value: MinbarBottomSheetStatus.shown);
  print(context.findAncestorStateOfType<MinbarScaffoldState>());
  context
      .findAncestorStateOfType<MinbarScaffoldState>()
      ?.addMinbarBottomSheet(MinbarBottomSheet(
        controller: controller,
        child: child,
        elevation: elevation,
        allowSlideInExpanded: allowSlideInExpanded,
        closeWhenLoseFocus: closeWhenLoseFocus,
        isTranslucent: isTranslucent,
      ));

  return controller;
}

class MinbarScaffold extends StatefulWidget {
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
  State<MinbarScaffold> createState() => MinbarScaffoldState();
}

class MinbarScaffoldState extends State<MinbarScaffold> {
  List<Widget> _bottomSheets = [];

  void addMinbarBottomSheet(MinbarBottomSheet bottomSheet) {
    bottomSheet.controller.addListener(() {
      if (bottomSheet.controller.isClosed && bottomSheet.collapseHeight > 0) {
        setState(() {
          _bottomSheets.remove(bottomSheet);
        });
      }
    });

    setState(() {
      _bottomSheets.add(bottomSheet);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = widget.bottomSheet != null ||
            widget.floatingActionButton != null ||
            _bottomSheets.isNotEmpty
        ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            widget.body,
            if (widget.floatingActionButton != null)
              widget.floatingActionButton as Widget,
            if (widget.bottomSheet != null) widget.bottomSheet as Widget,
            ..._bottomSheets
          ])
        : widget.body;

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          drawer: widget.hasDrawer ? SettingsLayout() : null,
          backgroundColor: widget.backgroundColor ?? DColors.white,
          extendBody: true,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          bottomNavigationBar: widget.navigationBar ??
              ((widget.hasBottomNavigationBar)
                  ? NavigationBar(
                      selectedIndex: widget.selectedIndex,
                      type: NavType.listen,
                      items: navigationItems,
                      navigationController: widget.navgationController,
                    )
                  : null),
          body: widget.withSafeArea
              ? SafeArea(bottom: false, child: _body)
              : _body,
        ));
  }
}
