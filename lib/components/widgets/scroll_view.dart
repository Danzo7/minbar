import 'package:flutter/material.dart';

class SpacedScrollView extends StatelessWidget {
  final List children;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  final double spacing;
  const SpacedScrollView(
      {Key? key,
      required this.children,
      this.scrollDirection = Axis.vertical,
      this.physics,
      this.shrinkWrap = false,
      required this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            child: children[index],
            padding: scrollDirection == Axis.vertical
                ? EdgeInsets.only(bottom: spacing)
                : EdgeInsets.only(right: spacing));
      },
    );
  }
}
