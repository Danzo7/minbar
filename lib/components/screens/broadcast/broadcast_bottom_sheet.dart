import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'Broadcast_screen.dart';

class BroadcastBottomSheet extends MinbarBottomSheet {
  BroadcastBottomSheet._(
      {required MinbarBottomSheetController controller,
      DragController? dragController})
      : super(
          radiusWhenNotExpanded: 44,
          allowSlideInExpanded: false,
          controller: controller,
          dragController: dragController,
          closeWhenLoseFocus: true,
          child: BroadcastScreen(
            hasComments: true,
            controller: controller,
            dragController: dragController,
          ),
          minHeight: 500,
        );

  factory BroadcastBottomSheet(
      {required MinbarBottomSheetController controller}) {
    final DragController dragController = DragController();
    return BroadcastBottomSheet._(
      controller: controller,
      dragController: dragController,
    );
  }
}
