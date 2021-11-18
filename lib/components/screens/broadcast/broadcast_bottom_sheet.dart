import 'package:minbar_fl/components/widgets/minbar_bottom_sheet.dart';
import 'Broadcast_screen.dart';

class BroadcastBottomSheet extends MinbarBottomSheet {
  BroadcastBottomSheet(
      {required MinbarBottomSheetController controller,
      DragController? dragController})
      : super(
          radiusWhenNotExpanded: 44,
          allowSlideInExpanded: false,
          controller: controller,
          dragController: dragController ?? DragController(),
          closeWhenLoseFocus: true,
          child: BroadcastScreen(
            hasComments: true,
            controller: controller,
            dragController: dragController ?? DragController(),
          ),
          minHeight: 500,
        );
}
