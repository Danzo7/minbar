import 'package:flutter/material.dart';

import 'sliver_header_container.dart';

class SliverHead extends StatelessWidget {
  final bool pinned, floating;
  final Widget child;
  final double maxHeight;
  final double? minHeight;
  const SliverHead(
      {Key? key,
      this.pinned = false,
      this.floating = false,
      required this.child,
      required this.maxHeight,
      this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: SliverHeaderContainer(
        maxHeight: maxHeight,
        minHeight: minHeight,
        child: child,
      ),
    );
  }
}
