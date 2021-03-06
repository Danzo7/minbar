import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/action_button.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/middle_controller.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/minbar_navigation_bar.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_item.dart';
import 'package:minbar_fl/core/services/cast_service.dart';
import 'package:minbar_fl/misc/page_navigation.dart';
import 'package:provider/provider.dart';

class MinbarBar extends StatelessWidget {
  final MiddleController middleController = MiddleController();
  final int selectedIndex;
  final List<NavigatonItem> items;
  final NavgationController? navigationController;

  MinbarBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    this.navigationController,
  })  : assert(items.length % 2 == 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MinbarNavigationBar(
            selectedIndex: selectedIndex,
            items: items,
            navigationController: navigationController,
            middleController: middleController),
        Consumer<CastService>(builder: (context, state, child) {
          if (state.currentCast == null) {
            middleController.normal();
          } else {
            middleController.outside();
          }

          return ActionButton(state: state, middleController: middleController);
        })
      ],
    );
  }
}
