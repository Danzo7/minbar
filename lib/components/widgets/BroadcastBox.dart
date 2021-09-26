import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/soda_icons_icons.dart';
import 'package:minbar_fl/components/static/textStyles.dart';

import 'buttons/buttons.dart';

class BroadcastBox extends StatelessWidget {
  const BroadcastBox({
    Key? key,
    required this.subject,
    required this.field,
    required this.host,
  }) : super(key: key);

  static const img = const AssetImage('assets/images/cover.png');
  static const listenersIcon = const Icon(
    SodaIcons.listeners,
    size: 15,
    color: Colors.white,
  );
  static const pauseIcon = const Icon(
    SodaIcons.pause,
    size: 35,
    color: Colors.white,
  );

  final String subject, field, host;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: img, fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(17)),
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
                      child: Wrap(
                          spacing: 2,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text(
                              "115",
                              style: DTextStyle.w12,
                              textAlign: TextAlign.center,
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
