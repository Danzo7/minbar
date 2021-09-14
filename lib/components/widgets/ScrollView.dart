import 'package:flutter/material.dart';

class SpacedScrollView extends StatelessWidget {
  final List children;
  final double? spaceSize;
  final Axis scrollDirection;
  const SpacedScrollView(
      {Key? key,
      required this.children,
      this.spaceSize,
      this.scrollDirection = Axis.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: scrollDirection,
        shrinkWrap: false,
        clipBehavior: Clip.antiAlias,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return scrollDirection == Axis.vertical
              ? SizedBox(
                  height: spaceSize,
                )
              : SizedBox(
                  width: spaceSize,
                );
        });
  }
}
