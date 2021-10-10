import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/default_colors.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';

class MinbarScaffold extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final bool withSafeArea;
  const MinbarScaffold(
      {Key? key,
      required this.selectedIndex,
      required this.body,
      this.withSafeArea = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.white,
      extendBody: true,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        type: NavType.broadcastable,
      ),
      body: withSafeArea ? SafeArea(bottom: false, child: body) : body,
    );
  }
}
