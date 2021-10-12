import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_text_styles.dart';

class Tree extends StatelessWidget {
  final List<Widget> children;
  final String name;
  const Tree({
    Key? key,
    required this.children,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              name,
              style: DTextStyle.bg12b,
            ),
          ),
          Wrap(direction: Axis.horizontal, runSpacing: 5, children: children),
        ],
      ),
    );
  }
}
