import 'package:flutter/material.dart';

class MinbarPageView extends StatelessWidget {
  final List<Widget> children;
  const MinbarPageView({
    Key? key,
    required PageController controller,
    required this.children,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
