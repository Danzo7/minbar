import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import 'package:minbar_fl/model/cast.dart';

import 'buttons/buttons.dart';

class BroadcastBox extends StatelessWidget {
  const BroadcastBox(this.cast, {Key? key}) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/cover.png'),
              fit: BoxFit.fitWidth),
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
                    child: const Icon(SodaIcons.pause,
                        size: 35, color: Colors.white)),
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
                          child: Text(cast.field, style: DTextStyle.w10),
                          backgroundColor: DColors.orange,
                          raduis: 7,
                          spacing: 5,
                        ),
                        AutoSizeText(
                          cast.subject,
                          style: DTextStyle.w20s,
                          minFontSize: 12,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          cast.hostUsername,
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
                            const Icon(
                              SodaIcons.listeners,
                              size: 15,
                              color: Colors.white,
                            )
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
