import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/text_styles.dart';

class Content extends StatelessWidget {
  final String value;
  const Content({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AutoSizeText(
        value,
        maxFontSize: 15,
        maxLines: 5,
        minFontSize: 10,
        style: DTextStyle.b15,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
