import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';

import 'Broadcast_page.dart';

class BroadcastBottomSheet extends StatelessWidget {
  BroadcastBottomSheet({Key? key, required this.controller}) : super(key: key);
  final MinbarBottomSheetController controller;
  final DragController dragController = DragController();
  @override
  Widget build(BuildContext context) {
    return MinbarBottomSheet(
      radiusWhenNotExpanded: 44,
      allowSlideInExpanded: false,
      controller: controller,
      dragController: dragController,
      closeWhenLoseFocus: true,
      child: BroadcastPage(
        hasComments: true,
        controller: controller,
        dragController: dragController,
      ),
      minHeight: 500,
    );
  }
}
