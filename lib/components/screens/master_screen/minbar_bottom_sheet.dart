import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///default duration equal to `400ms`
const Duration _kDefaultTiming = Duration(milliseconds: 400);

class MinbarBottomSheet extends StatefulWidget {
  final MinbarBottomSheetController controller;
  final DragController? dragController;

  final Function(MinbarBottomSheetStatus)? onStatusChanged;

  ///material elevation
  final double elevation;
  final double collapseHeight;
  final bool slideToExpand;

  ///if true [MinbarBottomSheet] will be always shown and the only way to close it is by calling controller.close()
  final bool closeWhenLoseFocus;
  final bool allowSlideInExpanded;

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

  final Widget? header;

  const MinbarBottomSheet({
    Key? key,
    required this.controller,
    this.onStatusChanged,
    this.elevation = 0,
    required this.child,
    this.minHeight,
    this.maxHeight,
    this.radiusWhenNotExpanded = 0,
    this.slideToExpand = true,
    this.allowSlideInExpanded = true,
    this.closeWhenLoseFocus = true,
    this.collapseHeight = 0,
    this.header,
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

  _MinbarBottomSheetState();

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
    widget.dragController?.addDragListener(_onVerticalDragUpdate);
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
//reset the listener when its lost in hot reload
    // ignore: invalid_use_of_protected_member
    if (!widget.controller.hasListeners && mounted)
      widget.controller.addListener(_onStateChange);
    widget.dragController?.addDragListener((_onVerticalDragUpdate));

    //_initialize(context);
    super.didUpdateWidget(oldWidget);
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
                      onVerticalDragEnd: _onVerticalDragEnd,
                      onVerticalDragUpdate: _onVerticalDragUpdate,
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
    if (!mounted) {
      return;
    }
    print(details.primaryDelta);

    setState(() {
      if (!((!widget.slideToExpand &&
              _animationController.value == _minFraction) ||
          (!widget.allowSlideInExpanded &&
              _animationController.value == _maxFraction)))
        _animationController.value = max(
            _collapseFraction,
            _animationController.value -
                (details.primaryDelta! /
                    (_childHeight ?? details.primaryDelta!)));
      print(_animationController.value);
    });
    _animatedRaduis();
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
    print(_collapseFraction);
    if (_animationController.value != _collapseFraction)
      _animationController
          .animateTo(_collapseFraction,
              curve: Curves.linearToEaseOut, duration: _kDefaultTiming)
          .then((value) {
        if (!mounted) {
          return;
        }
        setState(() {
          _enable = _collapseFraction != 0;
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

class DragController extends ValueNotifier<DragUpdateDetails> {
  DragController({DragUpdateDetails? value})
      : super(value ?? DragUpdateDetails(globalPosition: const Offset(0, 0)));

  void addDragListener(Function(DragUpdateDetails) listener) {
    super.addListener(() => listener(value));
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
