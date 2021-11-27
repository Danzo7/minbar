import 'package:minbar_fl/components/screens/broadcast/broadcast_screen.dart';
import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';

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
