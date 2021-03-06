import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

enum FallBehavoir { fallToOrigin, fallToBorder, none }

//floating_widget
class FloatingWidget extends StatefulWidget {
  FloatingWidget(
      {Key? key,
      required this.child,
      this.onDragEnd,
      this.onDragStart,
      this.onTap,
      required this.snaps,
      this.elevation = 1,
      this.padding,
      this.withHitDetection = false,
      this.axis,
      this.onDragCanceled,
      this.fallBehavoir = FallBehavoir.fallToBorder})
      : super(key: key);

  final void Function()? onDragEnd;
  final void Function()? onDragCanceled;
  final void Function()? onDragStart;
  final void Function()? onTap;

  final Axis? axis;

  final Widget child;

  final double elevation;

  final EdgeInsets? padding;

  final List<_Snapable> snaps;

  ///set to  false in case of not using Hit detection
  final bool withHitDetection;
  final FallBehavoir fallBehavoir;

  @override
  _FloatingWidgetState createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with TickerProviderStateMixin<FloatingWidget> {
  Offset lastOriginOffset = Offset.zero;
  late final DragPositionController controller;
  bool ov = false;

  final GlobalKey _childKey = GlobalKey(debugLabel: 'floatingWidget');

  double? get _childWidth {
    double? width;
    RenderObject? current = _childKey.currentContext?.findRenderObject();
    if (current != null) {
      if (mounted) {
        width = (current as RenderBox).hasSize ? current.size.width : null;
      }
      return width;
    }
  }

  @override
  void didUpdateWidget(covariant FloatingWidget oldWidget) {
    controller.initAnimation(this);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = DragPositionController(axis: widget.axis);
    controller.initAnimation(this);

    super.initState();
  }

  void enableOV() {
    setState(() {
      ov = true;
    });
  }

  void disableOV() {
    setState(() {
      ov = false;
    });
  }

  void _pressUpdate(LongPressMoveUpdateDetails details) {
    Offset pos = Offset(lastOriginOffset.dx + details.offsetFromOrigin.dx,
        lastOriginOffset.dy + details.offsetFromOrigin.dy);
    if (widget.withHitDetection) {
      bool found = false;
      for (var snap in widget.snaps) {
        if (((pos - snap.pos).distance <= snap.radius) && !found) {
          found = !found;
          pos = snap.pos;
          if (snap is HitSnapLocation) {
            (snap)._isHited.value = true;
          }
        } else {
          if (snap is HitSnapLocation) {
            (snap)._isHited.value = false;
          }
        }
      }
      controller.animateTo(pos, duration: Duration(milliseconds: 40));
    } else {
      controller.animateTo(
          widget.snaps
              .firstWhere((snap) => (pos - snap.pos).distance <= snap.radius,
                  orElse: () => SnapLocation(pos: details.offsetFromOrigin))
              .pos,
          duration: Duration(milliseconds: 40));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: ov ? widget.elevation : 0,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ...widget.snaps
                .map((e) => AnimatedOpacity(
                      duration: kFastAnimationDuration,
                      opacity: ov ? 1 : 0,
                      child: Transform.translate(
                        offset: e.pos,
                        child: e.snapLocator,
                      ),
                    ))
                .toList(),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: GestureDetector(
                onTap: widget.onTap,
                onLongPressStart: pressStart,
                onLongPressMoveUpdate: _pressUpdate,
                onLongPressEnd: pressEnd,
                child: ValueListenableBuilder(
                  builder: (context, Offset pos, child) {
                    return Transform.translate(
                      offset: pos,
                      child: child,
                    );
                  },
                  valueListenable: controller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        key: _childKey,
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pressEnd(LongPressEndDetails details) {
    bool isSnaped = false;
    for (var snap in widget.snaps) {
      if (snap.onSnap != null &&
          (controller.pos - snap.pos).distance <= snap.radius) {
        snap.onSnap!();
        isSnaped = true;
      }
    }
    if (widget.onDragCanceled != null && !isSnaped) {
      widget.onDragCanceled!();
    }
    if (widget.onDragEnd != null) widget.onDragEnd!();

    disableOV();
    switch (widget.fallBehavoir) {
      case FallBehavoir.fallToOrigin:
        break;
      case FallBehavoir.none:
        lastOriginOffset = controller.pos;
        break;
      case FallBehavoir.fallToBorder:
        lastOriginOffset = Offset(
            ((controller.pos.dx) > 0
                ? (MediaQuery.of(context).size.width - (_childWidth ?? 0)) / 2
                : ((_childWidth ?? 0) - MediaQuery.of(context).size.width) / 2),
            controller.pos.dy);
        break;
    }
    controller.animateTo(lastOriginOffset, duration: kMedAnimationDuration);
  }

  void pressStart(details) {
    if (widget.onDragStart != null) widget.onDragStart!();

    enableOV();
  }
}

class DragPositionController extends ValueNotifier<Offset> {
  DragPositionController({this.axis})
      : newValue = Offset.zero,
        super(Offset(0, 0));
  final Axis? axis;
  Offset newValue;
  AnimationController? xAnim, yAnim;

  @override
  void dispose() {
    xAnim?.dispose();
    yAnim?.dispose();
    super.dispose();
  }

  get pos => newValue;

  void initAnimation(TickerProvider vsync) {
    if (axis == null || (axis != null && axis == Axis.horizontal)) {
      xAnim = AnimationController(
        vsync: vsync,
      );
    }
    if (axis == null || (axis != null && axis == Axis.vertical)) {
      yAnim = AnimationController(
        vsync: vsync,
      );
    }
    xAnim?.addListener(x);
    yAnim?.addListener(y);
  }

  set position(offset) => value = newValue = offset;

  void animateTo(Offset position, {Duration? duration}) {
    newValue = position;
    bol();

    yAnim?.animateTo(1, duration: duration).whenComplete(end);
    xAnim?.animateTo(1, duration: duration).whenComplete(end);
  }

  void end() {
    yAnim?.value = 0.0;
    xAnim?.value = 0.0;
  }

  void bol() {
    yAnim?.value = (0.09);
    xAnim?.value = (0.09);
  }

  void x() {
    value = Offset(xAnim!.value * (newValue - value).dx + value.dx, value.dy);
  }

  void y() {
    value = Offset(value.dx, yAnim!.value * (newValue - value).dy + value.dy);
  }
}

class SnapLocation extends _Snapable {
  const SnapLocation(
      {Function? onSnap,
      Offset pos = Offset.zero,
      double radius = 0,
      Widget? snapLocator})
      : super(
            onSnap: onSnap, pos: pos, radius: radius, snapLocator: snapLocator);
}

abstract class _Snapable {
  const _Snapable({
    this.pos = Offset.zero,
    this.radius = 0,
    this.onSnap,
    this.snapLocator,
  });

  final Function? onSnap;
  final Offset pos;
  final double radius;
  final Widget? snapLocator;
}

class HitSnapLocation extends _Snapable {
  HitSnapLocation(
      {required this.onHitChange,
      Function? onSnap,
      Offset pos = Offset.zero,
      double radius = 0,
      Widget? snapLocator})
      : super(
            onSnap: onSnap,
            pos: pos,
            radius: radius,
            snapLocator: snapLocator) {
    _isHited.addListener(() {
      onHitChange(_isHited.value);
    });
  }

  final void Function(bool isHited) onHitChange;

  final ValueNotifier<bool> _isHited = ValueNotifier<bool>(false);
}
