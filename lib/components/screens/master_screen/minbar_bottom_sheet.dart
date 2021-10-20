import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///default duration equal to `400ms`
const Duration _kDefaultTiming = Duration(milliseconds: 400);

class MinbarBottomSheet extends StatefulWidget {
  final MinbarBottomSheetController controller;

  final Function(MinbarBottomSheetStatus)? onStatusChanged;

  ///material elevation
  final double elevation;

  /// its better to pass the [MinbarBottomSheetController] to child to be able to manipulate [MinbarBottomSheet] from the child itself
  final Widget child;

  ///the minimum Height that [MinbarBottomSheet] will be shown in.
  ///used when call ``MinbarBottomSheetController.show()``.
  ///take the value of mnHeight in case of ``null``
  final double? minHeight;

  ///maximum height that [MinbarBottomSheet] could be expanded to.
  ///used when called `MinbarBottomSheetController.expand()`
  ///take child height in case of `null`.
  final double? maxHeight;

  /// a [BorderRaduis] will be aplied when [MinbarBottomSheet] is not expanded and desapear when it expanded
  final double radiusWhenNotExpanded;

  const MinbarBottomSheet({
    Key? key,
    required this.controller,
    this.onStatusChanged,
    this.elevation = 0,
    required this.child,
    this.minHeight,
    this.maxHeight,
    this.radiusWhenNotExpanded = 0,
  }) : super(key: key);
  @override
  State<MinbarBottomSheet> createState() => _MinbarBottomSheetState();
}

class _MinbarBottomSheetState extends State<MinbarBottomSheet>
    with SingleTickerProviderStateMixin<MinbarBottomSheet>, ChangeNotifier {
  bool _enable = false;
  double _snapByDitance = 0.2;
  late AnimationController _animationController;
  late Animation<Offset> animation;
  double _minFraction = 0.0;
  double _maxFraction = 1.0;
  double _radius = 0;
  final GlobalKey _childKey = GlobalKey(debugLabel: 'MinbarbottomSheet child');

  _MinbarBottomSheetState();

  double? get _childHeight {
    RenderBox? renderBox =
        _childKey.currentContext?.findRenderObject()! as RenderBox?;
    return renderBox?.size.height;
  }

  void _initialize(BuildContext context) {
    _radius = widget.radiusWhenNotExpanded;
    _minFraction = (widget.minHeight ??
            widget.maxHeight ??
            MediaQuery.of(context).size.height) /
        MediaQuery.of(context).size.height;
    _maxFraction = (widget.maxHeight ?? MediaQuery.of(context).size.height) /
        MediaQuery.of(context).size.height;

    switch (widget.controller.value) {
      case MinbarBottomSheetStatus.disabled:
        _enable = false;
        _animationController.value = 0;
        break;
      case MinbarBottomSheetStatus.expanded:
        _animationController.value = _maxFraction;
        break;
      case MinbarBottomSheetStatus.shown:
        _animationController.value = _minFraction;
        break;
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

    animation = _animationController.drive(
      Tween(begin: Offset(0.0, 1), end: Offset.zero).chain(
        CurveTween(
          curve: Curves.linear,
        ),
      ),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) => _initialize(context));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MinbarBottomSheet oldWidget) {
//reset the listener when its lost in hot reload
    if (!widget.controller.hasListeners)
      widget.controller.addListener(_onStateChange);
    _initialize(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _enable
        ? GestureDetector(
            onVerticalDragEnd: _onVerticalDragEnd,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            child: Material(
              color: Colors.transparent,
              elevation: widget.elevation,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: false,
                  removeBottom: true,
                  child: SafeArea(
                    child: Container(
                      key: _childKey,
                      alignment: Alignment.bottomCenter,
                      height: _childHeight,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return SlideTransition(
                            child: child,
                            position: animation,
                          );
                        },
                        child: GestureDetector(
                          onTap: () => {},
                          child: AnimatedContainer(
                            clipBehavior: Clip.hardEdge,
                            duration: Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(_radius),
                                    bottom: Radius.circular(
                                        widget.radiusWhenNotExpanded))),
                            child: widget.child,
                          ),
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
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
            },
          )
        : Container();
  }

  void _onStateChange() {
    setRaduis();
    setState(() {
      widget.onStatusChanged?.call(widget.controller.value);
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

  void _onVerticalDragEnd(DragEndDetails details) {
    double _snapByVelocity =
        max(0, _snapByDitance - (details.velocity.pixelsPerSecond.dy / 10000));

    if (_animationController.value <= _minFraction)
      (widget.controller.value != MinbarBottomSheetStatus.disabled &&
              _animationController.value < _minFraction - _snapByVelocity)
          ? widget.controller.close()
          : widget.controller.show();
    else {
      (widget.controller.value == MinbarBottomSheetStatus.expanded &&
              _animationController.value < _maxFraction - _snapByVelocity)
          ? widget.controller.close()
          : widget.controller.expand();
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _animationController.value -=
          details.primaryDelta! / (_childHeight ?? details.primaryDelta!);
    });
    _animatedRaduis();
  }

  void setRaduis() {
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

  void _expand() {
    if (_animationController.value != _maxFraction) {
      _enable = true;
      _animationController
          .animateTo(_maxFraction,
              curve: Curves.linearToEaseOut, duration: _kDefaultTiming)
          .then((value) => widget.controller.value =
              widget.controller.value != MinbarBottomSheetStatus.expanded
                  ? MinbarBottomSheetStatus.expanded
                  : widget.controller.value);
    }
  }

  void _show() {
    if (_animationController.value != _minFraction) {
      _enable = true;
      _animationController
          .animateTo(_minFraction,
              curve: Curves.linearToEaseOut, duration: _kDefaultTiming)
          .then((value) => widget.controller.value =
              widget.controller.value != MinbarBottomSheetStatus.shown
                  ? MinbarBottomSheetStatus.shown
                  : widget.controller.value);
    }
  }

  void _close() {
    if (_animationController.value != 0)
      _animationController
          .animateTo(0,
              curve: Curves.linearToEaseOut, duration: _kDefaultTiming)
          .then((value) {
        setState(() {
          _enable = false;
        });
        widget.controller.value =
            widget.controller.value != MinbarBottomSheetStatus.disabled
                ? MinbarBottomSheetStatus.disabled
                : widget.controller.value;
      });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
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

class MinbarBottomSheetController
    extends ValueNotifier<MinbarBottomSheetStatus> {
  MinbarBottomSheetController({MinbarBottomSheetStatus? value})
      : super(value != null ? value : MinbarBottomSheetStatus.disabled);

  MinbarBottomSheetStatus get status => value;

  ///Slide [MinbarBottomSheet] until become invisible then remove it content.
  void close() {
    if (value == MinbarBottomSheetStatus.disabled) notifyListeners();

    value = MinbarBottomSheetStatus.disabled;
  }

  ///slide  [MinbarBottomSheet] to `minHeight` ,if `minHeight=null` same as ``controller.expand()``
  void show() {
    if (value == MinbarBottomSheetStatus.shown) notifyListeners();

    value = MinbarBottomSheetStatus.shown;
  }

  ///slide [MinbarBottomSheet] to `maxHeight` if `minHeight=null` slide to whole screen.
  void expand() {
    if (value == MinbarBottomSheetStatus.expanded) notifyListeners();
    value = MinbarBottomSheetStatus.expanded;
  }
}

enum MinbarBottomSheetStatus { shown, expanded, disabled }
