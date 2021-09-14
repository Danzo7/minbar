import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/Icons.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/textStyles.dart';

import 'buttons/buttons.dart';

class BroadcastBox extends StatelessWidget {
  const BroadcastBox({
    Key? key,
    required this.subject,
    required this.field,
    required this.host,
  }) : super(key: key);
  final String subject, field, host;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/placeholder.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(17)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: () => {print("tap tap!")},
          child: Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContainButton(
                        child: Text(field, style: DTextStyle.w10),
                        backgroundColor: DColors.orange,
                        height: 22,
                        width: 40,
                        raduis: 7,
                      ),
                      AutoSizeText(
                        subject,
                        style: DTextStyle.w20b,
                        minFontSize: 12,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        host,
                        style: DTextStyle.w12,
                        minFontSize: 8,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: DIcons.getIcon(IconList.pause),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "115",
                            style:
                                TextStyle(color: DColors.white, fontSize: 12),
                          ),
                          DIcons.getIcon(IconList.listeners, size: 15)
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
