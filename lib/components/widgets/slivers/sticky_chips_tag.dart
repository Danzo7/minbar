import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/chips_tag.dart';
import 'package:minbar_fl/components/widgets/slivers/sliver_header_container.dart';

class StickyChipTag extends StatelessWidget {
  final Color? bgColor;
  final List<String> items;
  final BorderSides border;
  const StickyChipTag(
      {Key? key,
      this.bgColor,
      required this.items,
      this.border = BorderSides.none})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SliverHeaderContainer(
          child: ChipsTag(
            items: items,
            bgColor: bgColor,
            border: border,
          ),
          minHeight: 47,
          maxHeight: 47,
        ));
  }
}
