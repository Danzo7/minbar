import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/broadcast/broadcast_bottom_sheet.dart';
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
  context.findAncestorStateOfType<MinbarScaffoldState>()?.addMinbarBottomSheet(
      MinbarBottomSheet(
        controller: controller,
        child: child,
        elevation: elevation,
        allowSlideInExpanded: allowSlideInExpanded,
        closeWhenLoseFocus: closeWhenLoseFocus,
        isTranslucent: isTranslucent,
      ),
      controller);

  return controller;
}

MinbarBottomSheetController showBroadcastBottomSheet(
  BuildContext context,
) {
  MinbarBottomSheetController controller = MinbarBottomSheetController(
      isInstance: true, value: MinbarBottomSheetStatus.shown);
  context.findAncestorStateOfType<MinbarScaffoldState>()?.addMinbarBottomSheet(
      BroadcastBottomSheet(controller: controller), controller);

  return controller;
}

extension on List<Widget> {
  void addToLimit(bottomSheet) {
    this.add(bottomSheet);
    while (this.length > 3) this.removeAt(0);
  }
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

  void addMinbarBottomSheet(
      Widget bottomSheet, MinbarBottomSheetController controller) {
    controller.addListener(() {
      if (controller.isClosed) _bottomSheets.remove(bottomSheet);
    });

    controller.onClose = () {
      print("hello from ${_bottomSheets.length}");
      _bottomSheets.remove(bottomSheet);
      setState(() {});
    };

    print(_bottomSheets.length);
    _bottomSheets.addToLimit(bottomSheet);

    setState(() {});
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
