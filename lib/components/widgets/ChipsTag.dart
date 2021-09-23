import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/textStyles.dart';
import 'package:minbar_fl/components/widgets/ScrollView.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class ChipsTag extends StatefulWidget {
  final List<String> items;
  ChipsTag({Key? key, required this.items}) : super(key: key);

  @override
  _ChipsTagState createState() => _ChipsTagState();
}

class _ChipsTagState extends State<ChipsTag> {
  int _selectedItem = 0;
  _setSelectedItem(int index) {
    print(index);
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      color: DColors.coldGray,
      child: Container(
        height: 33,
        child: SpacedScrollView(
            scrollDirection: Axis.horizontal,
            spacing: 20,
            children: [
              ...widget.items
                  .map((e) => ContentButtonV2(
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
                      ))
                  .toList(),
            ]),
      ),
    );
  }
}
