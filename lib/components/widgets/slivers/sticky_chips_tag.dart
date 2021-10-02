import 'package:flutter/material.dart';

import '../chips_tag.dart';
import 'sliver_child.dart';

class StickyChipTag extends StatelessWidget {
  final Color? bgColor;
  final List<String> items;
  const StickyChipTag({Key? key, this.bgColor, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SliverChild(
          child: ChipsTag(
            items: items,
            bgColor: bgColor,
          ),
          minHeight: 47,
          maxHeight: 47,
        ));
  }
}