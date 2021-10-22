import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({
    Key? key,
    this.navigationBar,
    required this.pages,
    this.onPageChanged,
  }) : super(key: key);
  final Widget? navigationBar;
  final Map<String, Widget> pages;
  final void Function(int)? onPageChanged;
  @override
  State<PageNavigation> createState() {
    return _PageNavigationState(pages);
  }
}

class _PageNavigationState extends State<PageNavigation> {
  PageController? controller;
  Map<String, Widget> pages;
  _PageNavigationState(this.pages);
  @override
  void initState() {
    super.initState();
    controller = Pager.pushActor(this);
  }

  Widget build(BuildContext context) {
    return MinbarScaffold(
        withSafeArea: true,
        hasBottomNavigationBar: true,
        body: PageView(
          onPageChanged: widget.onPageChanged,
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: pages.values.toList(),
        ));
  }
}

class Pager {
  static List<_PageNavigationState> _actors = [];

  static PageController pushActor(_PageNavigationState actor) {
    PageController _controller = PageController(initialPage: 0);
    _actors.add(actor);
    return _controller;
  }

  static Future navigateToRoute<TO extends Object?>(
      BuildContext context, String routeName) {
    _PageNavigationState? state =
        context.findAncestorStateOfType<_PageNavigationState>();
    if (state != null) {
      print(state.pages.keys.toList().indexOf(routeName));
      if (state.pages.keys.contains(routeName))
        return Future(() => state.controller
            ?.jumpToPage(state.pages.keys.toList().indexOf(routeName)));
      else
        throw FlutterError("No page found with a name of $routeName");
    } else
      throw FlutterError("No PageNavigation found");
  }

  static Future navigateTo<TO extends Object?>(
      BuildContext context, int index) {
    _PageNavigationState? state =
        context.findAncestorStateOfType<_PageNavigationState>();
    if (state != null) {
      return Future(() => state.controller?.jumpToPage(index));
    } else
      throw FlutterError("No PageNavigation found");
  }
}
