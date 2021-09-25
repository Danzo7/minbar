import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/IconBuilder.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/textStyles.dart';

import 'buttons/buttons.dart';

class BroadcastBox extends StatelessWidget {
  static const img = const AssetImage('assets/images/placeholder.png');
  static const pauseIcon = const IconBuilder("pause");
  static const listenersIcon = const IconBuilder("listeners", size: 15);

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
          color: DColors.blueGray, borderRadius: BorderRadius.circular(17)),
      child: Container(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            RawMaterialButton(
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: pauseIcon,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
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
                        NotAButton(
                          child: Text(field, style: DTextStyle.w10),
                          backgroundColor: DColors.orange,
                          raduis: 7,
                          spacing: 5,
                        ),
                        AutoSizeText(
                          subject,
                          style: DTextStyle.w20s,
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
                    fit: FlexFit.tight,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "115",
                              style: DTextStyle.w12,
                            ),
                            listenersIcon
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
