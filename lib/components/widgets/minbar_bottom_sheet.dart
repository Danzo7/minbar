import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///default duration equal to `400ms`
const Duration _kDefaultTiming = Duration(milliseconds: 400);
Widget createLayout(body, bottomSheet) {
  return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [body, bottomSheet]);
}

class MinbarBottomSheet extends StatefulWidget {
  final MinbarBottomSheetController controller;
  final DragController? dragController;

  ///material elevation
  final double elevation;

  ///if true [MinbarBottomSheet] will be always shown and the only way to close it is by calling controller.close()
  final bool closeWhenLoseFocus;

  ///allow sliding(draging) after [MinbarBottomSheet] is expanded default=true as its the default behavoir.
  final bool allowSlideInExpanded;

  final bool slideToExpand;

  /// its better to pass the [MinbarBottomSheetController] to child to be able to manipulate [MinbarBottomSheet] from the child itself
  final Widget child;

  ///the minimum Height that [MinbarBottomSheet] will be shown in.
  ///used when call ``MinbarBottomSheetController.show()``.
  ///take the value of mnHeight in case of ``null``
  final double? minHeight;

  ///maximum height that [MinbarBottomSheet] could be expanded to.
  ///
  ///used when called `MinbarBottomSheetController.expand()`
  ///
  ///take child height in case of `null`.
  final double? maxHeight;

  /// ***beta***
  ///
  /// if ``collapseHeight>0`` [MinbarBottomSheet] will be always visible.
  ///
  ///somehow this is not accurate yet so its need adjusment to find correct height.
  final double collapseHeight;

  /// a [BorderRaduis] with raduis of ``radiusWhenNotExpanded`` will be aplied when [MinbarBottomSheet] is not expanded and desapear when it expanded.
  final double radiusWhenNotExpanded;

  const MinbarBottomSheet({
    Key? key,
    required this.controller,
    this.elevation = 0,
    required this.child,
    this.minHeight,
    this.maxHeight,
    this.radiusWhenNotExpanded = 0,
    this.slideToExpand = true,
    this.allowSlideInExpanded = true,
    this.closeWhenLoseFocus = true,
    this.collapseHeight = 0,
    this.dragController,
  }) : super(key: key);
  @override
  State<MinbarBottomSheet> createState() => _MinbarBottomSheetState();
}

class _MinbarBottomSheetState extends State<MinbarBottomSheet>
    with SingleTickerProviderStateMixin<MinbarBottomSheet> {
  bool _enable = false;
  double _snapByDitance = 0.2;
  late AnimationController _animationController;
  late Animation<Offset> animation;
  double _minFraction = 0.0;
  double _maxFraction = 1.0;
  double _collapseFraction = 0.0;
  double _radius = 0;
  bool firstRun = true;
  final GlobalKey _childKey =
      GlobalKey(debugLabel: 'MinbarbottomSheet${Random(100).nextInt(100)}');

  double? get _childHeight {
    double? height;
    RenderObject? current = _childKey.currentContext?.findRenderObject();
    if (current != null) {
      if (mounted)
        height = (current as RenderBox).hasSize ? current.size.height : null;
      return height;
    }
  }

  void _initialize(BuildContext context) {
    if (mounted) {
      _radius = widget.radiusWhenNotExpanded;
      _minFraction = (widget.minHeight ??
              widget.maxHeight ??
              MediaQuery.of(context).size.height) /
          MediaQuery.of(context).size.height;
      _maxFraction = (widget.maxHeight ??
              _childHeight ??
              MediaQuery.of(context).size.height) /
          MediaQuery.of(context).size.height;
      _collapseFraction =
          widget.collapseHeight / MediaQuery.of(context).size.height;
      switch (widget.controller.value) {
        case MinbarBottomSheetStatus.disabled:
          _enable = _collapseFraction != 0;
          _animationController.value = _collapseFraction;
          break;
        case MinbarBottomSheetStatus.expanded:
          _enable = true;
          _animationController.value = _maxFraction;
          break;
        case MinbarBottomSheetStatus.shown:
          _enable = true;
          _animationController.value = _minFraction;
          break;
      }
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: _kDefaultTiming,
      debugLabel: 'MinbarbottomSheet',
      vsync: this,
    );
    widget.controller.addListener(_onStateChange);
    widget.dragController?.addDragListener(_onDragChange);
    animation = _animationController.drive(
      Tween(begin: Offset(0.0, 1), end: Offset.zero).chain(
        CurveTween(
          curve: Curves.linear,
        ),
      ),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MinbarBottomSheet oldWidget) {
//reset the listeners if they lost in Hot reload
    widget.controller.addOnlyListener(_onStateChange);
    widget.dragController?.addOnlyListener(_onDragChange);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (firstRun) {
      _initialize(context);
      firstRun = false;
    }
    return _enable
        ? GestureDetector(
            child: Material(
              color: Colors.transparent,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: false,
                removeBottom: true,
                child: SafeArea(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      return SlideTransition(
                        child: child,
                        position: animation,
                      );
                    },
                    child: GestureDetector(
                      onVerticalDragEnd: (details) => _onVerticalDragEnd(
                          details.velocity.pixelsPerSecond.dy),
                      onVerticalDragUpdate: !(!widget.allowSlideInExpanded &&
                              widget.controller.value ==
                                  MinbarBottomSheetStatus.expanded)
                          ? (details) =>
                              _onVerticalDragUpdate(details.primaryDelta)
                          : null,
                      onTap: () => {},
                      excludeFromSemantics: true,
                      child: Material(
                        key: _childKey,
                        color: Colors.transparent,
                        elevation: widget.elevation,
                        child: AnimatedContainer(
                          clipBehavior: Clip.hardEdge,
                          duration: Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(_radius),
                                  bottom: Radius.circular(
                                      widget.radiusWhenNotExpanded))),
                          child: SizedBox(
                              height: widget.maxHeight ?? _childHeight,
                              child: widget.child),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: widget.closeWhenLoseFocus ? _clickOutsideClose : null,
          )
        : SizedBox();
  }

  _clickOutsideClose() {
    switch (widget.controller.status) {
      case MinbarBottomSheetStatus.shown:
        widget.controller.close();
        break;
      case MinbarBottomSheetStatus.expanded:
        widget.controller.close();

        break;
      case MinbarBottomSheetStatus.disabled:
        break;
    }
  }

  void _onStateChange() {
    setRaduis();
    if (!mounted) {
      return;
    }
    setState(() {
      switch (widget.controller.value) {
        case MinbarBottomSheetStatus.shown:
          _show();
          break;
        case MinbarBottomSheetStatus.expanded:
          _expand();
          break;
        case MinbarBottomSheetStatus.disabled:
          _close();
          break;
      }
    });
  }

  void _onDragChange({double? value, double? velocity}) {
    if (!mounted) {
      return;
    }
    if (value != null) _onVerticalDragUpdate(value);

    if (velocity != null) _onVerticalDragEnd(velocity);
  }

  void _onVerticalDragUpdate(double? primaryDelta) {
    if (!mounted) {
      return;
    }

    setState(() {
      if (!(!widget.slideToExpand &&
          _animationController.value == _minFraction))
        _animationController.value = max(
            _collapseFraction,
            _animationController.value -
                (primaryDelta! / (_childHeight ?? primaryDelta)));
    });
    _animatedRaduis();
  }

  void _onVerticalDragEnd(double velocity) {
    double _snapByVelocity = max(0, _snapByDitance - (velocity / 10000));

    if (_animationController.value <= _minFraction)
      (!widget.controller.isClosed &&
              _animationController.value < _minFraction - _snapByVelocity)
          ? widget.controller.close()
          : widget.controller.show();
    else {
      (widget.controller.isExpanded &&
              _animationController.value < _maxFraction - _snapByVelocity)
          ? widget.controller.close()
          : widget.controller.expand();
    }
  }

  void _expand() {
    if (_animationController.value != _maxFraction) {
      _enable = true;
      _animationController.animateTo(_maxFraction,
          curve: Curves.linearToEaseOut, duration: _kDefaultTiming);
    }
  }

  void _show() {
    if (_animationController.value != _minFraction) {
      _enable = true;
      _animationController.animateTo(_minFraction,
          curve: Curves.linearToEaseOut, duration: _kDefaultTiming);
    }
  }

  void _close() {
    if (_animationController.value != _collapseFraction)
      _animationController
          .animateTo(_collapseFraction,
              curve: Curves.linearToEaseOut, duration: _kDefaultTiming)
          .then((value) {
        setState(() {
          _enable = _collapseFraction != 0;
        });
      });
  }

  void setRaduis() {
    if (widget.radiusWhenNotExpanded != 0)
      switch (widget.controller.value) {
        case MinbarBottomSheetStatus.shown:
          _radius = widget.radiusWhenNotExpanded;
          break;
        case MinbarBottomSheetStatus.expanded:
          _radius = 0;
          break;
        case MinbarBottomSheetStatus.disabled:
          _radius = widget.radiusWhenNotExpanded;

          break;
      }
  }

  void _animatedRaduis() {
    _radius = max(
        0,
        _animationController.value > _minFraction
            ? (widget.radiusWhenNotExpanded -
                widget.radiusWhenNotExpanded *
                    ((_animationController.value - _minFraction) /
                        (_maxFraction - _minFraction)))
            : widget.radiusWhenNotExpanded);
  }
}

class _DragDetails {
  final double? value;
  final double? velocity;
  const _DragDetails({this.value, this.velocity});
}

///[DragController] used to control vertical draging(sliding) of [MinbarBottomSheet].
///to use it correctly link it with a [GestureDetector] widget.
class DragController extends ValueNotifier<_DragDetails> {
  DragController() : super(const _DragDetails());
  void addDragListener(
      void Function({double? value, double? velocity}) listener) {
    super.addListener(
        () => listener(value: _drag.value, velocity: _drag.velocity));
  }

  void addOnlyListener(Function({double? value, double? velocity}) listener) {
    if (!hasListeners) addDragListener(listener);
  }

  _DragDetails get _drag => value;
  set _drag(_DragDetails drag) => value = drag;

  ///pass this to onVerticalDragUpdate parameter in [GestureDetector] widget.
  void dragUpdate(DragUpdateDetails details) =>
      _drag = _DragDetails(value: details.primaryDelta);

  ///pass this to onVerticalDragEnd parameter in [GestureDetector] widget.
  void dragEnd(DragEndDetails details) =>
      _drag = _DragDetails(velocity: details.velocity.pixelsPerSecond.dy);
}

class MinbarBottomSheetController
    extends ValueNotifier<MinbarBottomSheetStatus> {
  MinbarBottomSheetController({MinbarBottomSheetStatus? value})
      : super(value != null ? value : MinbarBottomSheetStatus.disabled);
  MinbarBottomSheetStatus get status => value;

  ///Slide [MinbarBottomSheet] until become invisible then remove it content.
  void close() {
    if (isClosed) notifyListeners();

    value = MinbarBottomSheetStatus.disabled;
  }

  ///slide  [MinbarBottomSheet] to `minHeight` ,if `minHeight=null` same as ``controller.expand()``
  void show() {
    if (isShown) notifyListeners();

    value = MinbarBottomSheetStatus.shown;
  }

  ///slide [MinbarBottomSheet] to `maxHeight` if `minHeight=null` slide to whole screen.
  void expand() {
    if (isExpanded) notifyListeners();
    value = MinbarBottomSheetStatus.expanded;
  }

  ///add listener if its the only one.
  void addOnlyListener(void Function() listener) {
    if (!hasListeners) addListener(listener);
  }

  bool get isShown => value == MinbarBottomSheetStatus.shown;
  bool get isExpanded => value == MinbarBottomSheetStatus.expanded;
  bool get isClosed => value == MinbarBottomSheetStatus.disabled;
}

enum MinbarBottomSheetStatus { shown, expanded, disabled }
