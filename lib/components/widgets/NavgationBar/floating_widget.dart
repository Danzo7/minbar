import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';

//floating_widget
class FloatingWidget extends StatefulWidget {
  FloatingWidget(
      {Key? key,
      required this.child,
      this.onDragEnd,
      this.onDragStart,
      this.onTap,
      required this.snap,
      this.elevation = 1,
      this.padding,
      this.withHitDetection = false,
      this.axis,
      this.onDragCanceled})
      : super(key: key);

  final void Function()? onDragEnd;
  final void Function()? onDragCanceled;
  final void Function()? onDragStart;
  final void Function()? onTap;
  final Axis? axis;
  final Widget child;
  final double elevation;
  final EdgeInsets? padding;
  final List<_Snapable> snap;
  final bool withHitDetection;

  @override
  _FloatingWidgetState createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with TickerProviderStateMixin<FloatingWidget> {
  late final DragPositionController controller;
  bool ov = false;

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
    controller = DragPositionController();
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

  void _onLongPressedUpdate(LongPressMoveUpdateDetails details) {
    // controller.value = details.offsetFromOrigin;
    if (widget.withHitDetection) {
      Offset pos = details.offsetFromOrigin;
      bool found = false;
      for (var snap in widget.snap) {
        if (((details.offsetFromOrigin - snap.pos).distance <= snap.radius) &&
            !found) {
          found = !found;
          pos = snap.pos;
          if (snap is HitSnapTap) {
            (snap)._isHited.value = true;
          }
        } else {
          if (snap is HitSnapTap) {
            (snap)._isHited.value = false;
          }
        }
      }
      controller.animateTo(pos, duration: Duration(milliseconds: 40));
    } else {
      controller.animateTo(
          widget.snap
              .firstWhere(
                  (snap) =>
                      (details.offsetFromOrigin - snap.pos).distance <=
                      snap.radius,
                  orElse: () => SnapTap(pos: details.offsetFromOrigin))
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
            ...widget.snap
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
                onLongPressStart: (details) {
                  if (widget.onDragStart != null) widget.onDragStart!();

                  enableOV();
                },
                onLongPressMoveUpdate: _onLongPressedUpdate,
                onLongPressEnd: (details) {
                  bool isSnaped = false;
                  for (var snap in widget.snap) {
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
                  controller.animateTo(Offset.zero,
                      duration: kMedAnimationDuration);
                },
                child: ValueListenableBuilder(
                  builder: (context, Offset pos, child) {
                    return Transform.translate(
                      offset: pos,
                      child: child,
                    );
                  },
                  valueListenable: controller,
                  child: Container(
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DragPositionController extends ValueNotifier<Offset> {
  DragPositionController()
      : newValue = Offset.zero,
        super(Offset(0, 0));

  Offset newValue;
  late AnimationController xAnim, yAnim;

  @override
  void dispose() {
    xAnim.dispose();
    yAnim.dispose();
    super.dispose();
  }

  get pos => newValue;

  void initAnimation(TickerProvider vsync) {
    xAnim = AnimationController(
      vsync: vsync,
    );

    yAnim = AnimationController(
      vsync: vsync,
    );

    xAnim.addListener(x);
    yAnim.addListener(y);
  }

  set position(offset) => value = newValue = offset;

  void animateTo(Offset position, {Duration? duration}) {
    newValue = position;
    bol();

    yAnim.animateTo(1, duration: duration).whenComplete(end);
    xAnim.animateTo(1, duration: duration).whenComplete(end);
  }

  void end() {
    yAnim.value = 0.0;
    xAnim.value = 0.0;
  }

  void bol() {
    yAnim.value = (0.09);
    xAnim.value = (0.09);
  }

  void x() {
    value = Offset(xAnim.value * (newValue - value).dx + value.dx, value.dy);
  }

  void y() {
    value = Offset(value.dx, yAnim.value * (newValue - value).dy + value.dy);
  }
}

class SnapTap extends _Snapable {
  const SnapTap(
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

class HitSnapTap extends _Snapable {
  HitSnapTap(
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
