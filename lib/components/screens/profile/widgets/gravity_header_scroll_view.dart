import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GraviryHeaderScrollView extends StatefulWidget {
  final List<Widget> slivers;
  final double gravityField;
  final int milliseconds;
  GraviryHeaderScrollView(
      {Key? key,
      required this.gravityField,
      this.slivers = const <Widget>[],
      this.milliseconds = 70})
      : super(key: key);
  @override
  State<GraviryHeaderScrollView> createState() =>
      _GraviryHeaderScrollViewState();
}

class _GraviryHeaderScrollViewState extends State<GraviryHeaderScrollView> {
  final ScrollController wheel = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      wheel.position.isScrollingNotifier.addListener(() {
        bool scrollStopped = !wheel.position.isScrollingNotifier.value;
        if (scrollStopped && wheel.position.pixels < widget.gravityField) {
          if (wheel.position.pixels > 0 &&
              wheel.position.pixels < widget.gravityField / 6)
            wheel.animateTo(0,
                duration: Duration(milliseconds: widget.milliseconds),
                curve: Curves.easeOutCubic);
          else if (wheel.position.pixels > (5 * widget.gravityField) / 6 &&
              wheel.position.pixels < widget.gravityField)
            wheel.animateTo(widget.gravityField,
                duration: Duration(milliseconds: widget.milliseconds),
                curve: Curves.easeOutCubic);
          else if (wheel.position.pixels > widget.gravityField / 6 &&
              wheel.position.pixels < (5 * widget.gravityField) / 6) if (wheel
                  .position.userScrollDirection ==
              ScrollDirection.reverse)
            wheel.animateTo(widget.gravityField,
                duration: Duration(milliseconds: widget.milliseconds),
                curve: Curves.bounceOut);
          else
            wheel.animateTo(0,
                duration: Duration(milliseconds: widget.milliseconds),
                curve: Curves.bounceOut);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: wheel, slivers: widget.slivers);
  }
}
