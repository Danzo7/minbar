import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

///default duration equal to `400ms`

const Duration _kDefaultTiming = Duration(milliseconds: 400);

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
  final bool snapToExpand;

  /// its better to pass the [MinbarBottomSheetController] to child to be able to manipulate [MinbarBottomSheet] from the child itself
  final Widget child;

  ///the minimum Height that [MinbarBottomSheet] will be shown in.
  ///used when call ``MinbarBottomSheetController.show()``.
  ///take the value of mnHeight in case of ``null``
  final double? minHeight;

  ///between 0 to maxFraction with 0 is fully hidden.

  final double? minFraction;

  ///maximum height that [MinbarBottomSheet] could be expanded to.
  ///
  ///used when called `MinbarBottomSheetController.expand()`
  ///
  ///take child height in case of `null`.
  final double? maxHeight;

  ///between minFraction to 1 with 1 is fully expanded
  final double? maxFraction;

  /// ***beta***
  ///
  /// if ``collapseHeight>0`` [MinbarBottomSheet] will be always visible.
  ///
  ///somehow this is not accurate yet so its need adjusment to find correct height.
  final double collapseHeight;

  /// a [BorderRaduis] with raduis of ``radiusWhenNotExpanded`` will be aplied when [MinbarBottomSheet] is not expanded and desapear when it expanded.
  final double radiusWhenNotExpanded;

  final bool constraint;

  ///enable Translucent behavoir of gestionDetector.
  ///
  ///set to false to disable any other GestionDetector behind [MinbarBottomSheet] if it is in range maxHeight.
  final bool isTranslucent;

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
    this.constraint = true,
    this.snapToExpand = true,
    this.minFraction,
    this.maxFraction,
    this.isTranslucent = true,
  })  : assert(
            (minHeight == null || minFraction == null) &&
                (maxFraction == null || maxHeight == null),
            "Specifiying fraction will override Height limitation so you should ether provide a fraction or a height limitation."),
        assert(minFraction == null || minFraction >= 0),
        assert(maxFraction == null || maxFraction <= 1),
        assert(
            (minFraction == null || maxFraction == null) ||
                (minFraction < maxFraction),
            "make sure that minFraction is smaller than maxFraction."),
        super(key: key);
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

  void _initFraction() {
    _minFraction = widget.minFraction ??
        (widget.minHeight ??
                widget.maxHeight ??
                MediaQuery.of(context).size.height) /
            MediaQuery.of(context).size.height;
    _maxFraction = widget.maxFraction ??
        (widget.maxHeight ?? MediaQuery.of(context).size.height) /
            MediaQuery.of(context).size.height;
    _collapseFraction =
        widget.collapseHeight / MediaQuery.of(context).size.height;
  }

  void _initialize(BuildContext context) {
    _initFraction();
    if (mounted) {
      _radius = widget.radiusWhenNotExpanded;

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
    //widget.controller.dispose();
    _animationController.dispose();
    if (widget.controller.isInstance) widget.controller._removeFromInstances();
    super.dispose();
  }

  Widget _fillSpace(bool fill, {required Widget child}) {
    return fill
        ? GestureDetector(
            onTap: widget.closeWhenLoseFocus ? _clickOutsideClose : null,
            behavior: widget.isTranslucent ? HitTestBehavior.translucent : null,
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: widget.elevation,
              child: Container(
                  color: !widget.isTranslucent ? Colors.transparent : null,
                  alignment: Alignment.bottomCenter,
                  child: child),
            ),
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    if (firstRun) {
      _initialize(context);
      firstRun = false;
    }
    return _enable
        ? _fillSpace(
            widget.closeWhenLoseFocus && !widget.controller.isClosed,
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
                  onVerticalDragEnd: (details) => !(!widget
                              .allowSlideInExpanded &&
                          widget.controller.value ==
                              MinbarBottomSheetStatus.expanded)
                      ? _onVerticalDragEnd(details.velocity.pixelsPerSecond.dy)
                      : null,
                  onVerticalDragUpdate: !(!widget.allowSlideInExpanded &&
                          widget.controller.value ==
                              MinbarBottomSheetStatus.expanded)
                      ? (details) => _onVerticalDragUpdate(details.primaryDelta)
                      : null,
                  onTap: () => {},
                  excludeFromSemantics: true,
                  child: Container(
                    key: _childKey,
                    child: AnimatedContainer(
                      clipBehavior: Clip.hardEdge,
                      duration: Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(_radius),
                      )),
                      height: !widget.constraint
                          ? widget.maxHeight ?? (_childHeight)
                          : null,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
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
    else if (widget.snapToExpand)
      (widget.controller.isExpanded &&
              _animationController.value < _maxFraction - _snapByVelocity)
          ? widget.controller.close()
          : widget.controller.expand();
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

///Control [MinbarBottomSheet] status.
class MinbarBottomSheetController extends ValueNotifier<MinbarBottomSheetStatus>
    with MinbarBottomSheetInstances {
  ///if ``true`` the controller is an instance.
  ///this mean that it will be added to a list of instances.
  ///This will allow to link all instances so it will be possible to Pop every [MinbarBottomSheet] one by one.
  ///by using mayPop() every [MinbarBottomSheet] will go from it status down until its closed `Expand->show->closed`.
  final bool isInstance;
  MinbarBottomSheetController(
      {MinbarBottomSheetStatus? value, this.isInstance = false})
      : super(value != null ? value : MinbarBottomSheetStatus.disabled);
  MinbarBottomSheetStatus get status => value;

  ///Slide [MinbarBottomSheet] until become invisible then remove it content.
  void close() {
    if (isClosed) notifyListeners();
    value = MinbarBottomSheetStatus.disabled;
    if (isInstance) _removeFromInstances();
  }

  ///slide  [MinbarBottomSheet] to `minHeight` ,if `minHeight=null` same as ``controller.expand()``
  void show() {
    if (isShown) notifyListeners();

    value = MinbarBottomSheetStatus.shown;
    if (isInstance) _addToInstances();
  }

  ///slide [MinbarBottomSheet] to `maxHeight` if `minHeight=null` slide to whole screen.
  void expand() {
    if (isExpanded) notifyListeners();
    value = MinbarBottomSheetStatus.expanded;

    if (isInstance) _addToInstances();
  }

  ///add listener if its the only one.
  void addOnlyListener(void Function() listener) {
    if (!hasListeners) addListener(listener);
  }

  bool get isShown => value == MinbarBottomSheetStatus.shown;
  bool get isExpanded => value == MinbarBottomSheetStatus.expanded;
  bool get isClosed => value == MinbarBottomSheetStatus.disabled;

  ///[MinbarBottomSheet] will go from it current status down until it closed `Expanded->Show->Closed`.
  ///return isClosed
  bool mayPop() {
    if (isShown) {
      close();
      return true;
    }

    if (isExpanded) {
      show();
      return true;
    } else
      return false;
  }

  ///this will remove the instance frome instances list.
  ///controllers will be removed automatically if [MinbarBottomSheet] is disabled .
  void _removeFromInstances() =>
      MinbarBottomSheetInstances._instances.remove(this);

  ///this will add the instance to instances.
  ///instances are used for  the mayPop() function.
  ///controllers will be added automatically if and [MinbarBottomSheet] is not disabled .
  void _addToInstances() => MinbarBottomSheetInstances._instances
    ..remove(this)
    ..add(this);
}

///[MinbarBottomSheetController] is an instance if ``isInstance=true``
///
///Each [MinbarBottomSheetController] that is an instance will be a part of ListOfInstances if its not closed.
///
///provide static call to `mayPop()` on the latest instance in ListOfInstances.
///an instance is no longer in ListOfInstances if it closed.
class MinbarBottomSheetInstances {
  static List<MinbarBottomSheetController> _instances = [];

  ///get last added instance if any.
  static MinbarBottomSheetController? get _lasestInstance =>
      MinbarBottomSheetInstances._instances.isNotEmpty
          ? MinbarBottomSheetInstances._instances.last
          : null;

  ///Will call `mayPop()` on the latest instance.
  ///
  ///it returns ``false`` if there is no latest instance ``listOfInstances.length=0``,
  ///and ``true`` otherwise.
  ///
  ///Here we are using it with WillPop() Widget to handle android backButton.
  ///
  ///```
  ///WillPopScope(
  /// onWillPop: () async {
  ///   if (MinbarBottomSheetInstances.mayPop())
  ///    return false;
  ///   else {return _handleBackButton()},
  /// child:App()
  /// ...
  /// )
  ///```
  ///Every [MinbarBottomSheet] that is linked with an instance `isInstance=true`, will go from it current status down until it closed `Expanded->Shown->Closed`.
  ///starting from latest intance until all intances are closed.

  static bool mayPop() {
    if (_lasestInstance != null)
      return _lasestInstance!.mayPop();
    else
      return false;
  }
}

enum MinbarBottomSheetStatus { shown, expanded, disabled }
