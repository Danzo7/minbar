import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

enum BorderSides { top, bottom, both, none }

class ChipsTag extends StatefulWidget {
  final List<String> items;
  final Color? bgColor;
  final BorderSides border;
  ChipsTag(
      {Key? key,
      required this.items,
      this.bgColor,
      this.border = BorderSides.none})
      : super(key: key);

  @override
  _ChipsTagState createState() => _ChipsTagState(border);
}

class _ChipsTagState extends State<ChipsTag> {
  AutoScrollController? _scrollController;
  final BorderSides border;
  _ChipsTagState(this.border);
  void initState() {
    super.initState();

    _scrollController = AutoScrollController(axis: Axis.horizontal);
  }

  void _scrollToIndex(int index) {
    _scrollController!.scrollToIndex(
      index,
      duration: kFastAnimationDuration,
    );
  }

  int _selectedItem = 0;
  _setSelectedItem(int index) {
    setState(() {
      _selectedItem = index;
      _scrollToIndex(index);
    });
  }

  Border? _createBorder() {
    switch (border) {
      case BorderSides.top:
        return Border(top: BorderSide(color: DColors.coldGray));
      case BorderSides.bottom:
        return Border(bottom: BorderSide(color: DColors.coldGray));
      case BorderSides.both:
        return Border(
            top: BorderSide(color: DColors.coldGray),
            bottom: BorderSide(color: DColors.coldGray));
      case BorderSides.none:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.bgColor ?? DColors.coldGray,
          border: widget.bgColor != null ? _createBorder() : null),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 33,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Wrap(spacing: 20, children: [
            ...widget.items
                .map((e) => AutoScrollTag(
                      key: ValueKey<int>(widget.items.indexOf(e)),
                      controller: _scrollController!,
                      index: widget.items.indexOf(e),
                      child: ContentButtonV2(
                        spacing: 25,
                        height: 33,
                        child: Text(e,
                            style: _selectedItem == widget.items.indexOf(e)
                                ? DTextStyle.w12b
                                : DTextStyle.b12b),
                        backgroundColor:
                            _selectedItem == widget.items.indexOf(e)
                                ? DColors.green
                                : Colors.transparent,
                        raduis: 100,
                        onTap: () => _setSelectedItem(widget.items.indexOf(e)),
                      ),
                    ))
                .toList(),
          ]),
        ),
      ),
    );
  }
}
