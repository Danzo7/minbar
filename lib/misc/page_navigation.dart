import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/misc/minbar_scaffold.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({
    Key? key,
    this.navigationBar,
    required this.pages,
    this.onPageChanged,
    required this.navgationController,
    this.slidable = false,
  }) : super(key: key);

  final void Function(int)? onPageChanged;
  final NavgationController navgationController;
  final Widget? navigationBar;
  final Map<String, Widget> pages;
  final bool slidable;

  @override
  State<PageNavigation> createState() {
    return _PageNavigationState(pages);
  }
}

class _PageNavigationState extends State<PageNavigation> {
  _PageNavigationState(this.pages);

  Map<String, Widget> pages;

  @override
  void initState() {
    Pager.latestController = widget.navgationController;
    super.initState();
  }

  Widget build(BuildContext context) {
    return MinbarScaffold(
        withSafeArea: true,
        body: PageView(
          reverse: true,
          onPageChanged: widget.onPageChanged,
          controller: widget.navgationController,
          children: pages.values.toList(),
          physics: !widget.slidable ? NeverScrollableScrollPhysics() : null,
        ));
  }
}

class Pager {
  static NavgationController? latestController;

  static Future navigateTo<TO extends Object?>(
      BuildContext context, int index) {
    NavgationController? navgationController = latestController ??
        context
            .findAncestorStateOfType<_PageNavigationState>()
            ?.widget
            .navgationController;
    if (navgationController != null) {
      return Future(() => navgationController.jumpToPage(index));
    } else
      throw FlutterError("No PageNavigation found");
  }
}

class NavgationController extends PageController {
  int currentPage = 0;
  final ListQueue<int> history = ListQueue();

  @override
  Future animateToPage(page,
      {required Curve curve, required Duration duration}) {
    currentPage = page;

    if (predectedPage != page) _pushToHistory(predectedPage);
    return super.animateToPage(page, curve: curve, duration: duration);
  }

  @override
  void jumpToPage(page) {
    currentPage = page;
    if (predectedPage != page) _pushToHistory(predectedPage);
    super.jumpToPage(page);
  }

  void _pushToHistory(int page) {
    history.remove(page);
    history.addLast(page);

    if (history.length > 1) {
      history.removeFirst();
    }
  }

  bool mayPop() {
    int? current = prev;
    current = current == predectedPage ? prev : current;
    super.jumpToPage(current ?? initialPage);
    if (history.isEmpty && current == null)
      return false;
    else
      return true;
  }

  void addChangeListener(Function(int index) listener) {
    addListener(() {
      if (currentPage != predectedPage) {
        _pushToHistory(predectedPage);
        currentPage = predectedPage;
      }
      listener(predectedPage);
    });
  }

  int get predectedPage => page?.round() ?? initialPage;

  int? get prev {
    return history.isNotEmpty ? history.removeLast() : null;
  }

  void navigateTo(int page) {
    jumpToPage(page);
  }
}
