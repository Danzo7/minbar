import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/broadcast/broadcast_bottom_sheet.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/minbar_bar.dart';
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

void showBroadcastBottomSheet(
  BuildContext context,
) {
  context.findAncestorStateOfType<MinbarScaffoldState>()?.addBroadcastSheet();
}

extension on List<Widget> {
  void addToLimit(Widget bottomSheet) {
    this.remove(this);
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
  bool overlay = true;

  List<Widget> _bottomSheets = [];
  MinbarBottomSheet? broadcastSheet;
  bool isShownbroadcastSheet = false;
  @override
  void initState() {
    super.initState();
  }

  void addMinbarBottomSheet(MinbarBottomSheet bottomSheet) {
    bottomSheet.controller.addListener(() {
      if (bottomSheet.controller.isClosed) _bottomSheets.remove(bottomSheet);
    });

    bottomSheet.controller.onClose = () {
      _bottomSheets.remove(bottomSheet);
      setState(() {});
    };

    setState(() {
      _bottomSheets.addToLimit(bottomSheet);
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
            if (broadcastSheet != null) broadcastSheet as Widget,
            ..._bottomSheets,
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
          bottomNavigationBar: widget.hasBottomNavigationBar
              ? MinbarBar(
                  selectedIndex: widget.selectedIndex,
                  items: navigationItems,
                  navigationController: widget.navgationController,
                )
              : widget.navigationBar,
          body: widget.withSafeArea
              ? SafeArea(bottom: false, child: _body)
              : _body,
        ));
  }

  void addBroadcastSheet() {
    if (broadcastSheet != null) {
      broadcastSheet!.controller.show();
      return;
    }

    setState(() {
      broadcastSheet = BroadcastBottomSheet(
          controller: MinbarBottomSheetController(
              isInstance: true, value: MinbarBottomSheetStatus.shown));
    });
  }
}
