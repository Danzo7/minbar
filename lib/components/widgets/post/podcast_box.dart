import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/soda_icons_icons.dart';
import 'package:minbar_fl/components/static/text_styles.dart';

class PodcastBox extends StatelessWidget {
  final String listenCount;
  final String timeLength;
  const PodcastBox({
    Key? key,
    this.listenCount = "1.2k",
    this.timeLength = "00:30:21",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: const AssetImage('assets/images/cover.png'),
              fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(17)),
      child: Container(
        height: 88,
        child: Stack(
          children: [
            RawMaterialButton(
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              child: Container(
                alignment: Alignment.center,
                child: const Icon(
                  SodaIcons.pause,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topRight,
                      child: Wrap(
                          spacing: 3,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text(
                              timeLength,
                              style: DTextStyle.w12,
                              textAlign: TextAlign.center,
                            ),
                            const Icon(SodaIcons.clock,
                                color: DColors.white, size: 15)
                          ])),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Text(
                            listenCount,
                            style: DTextStyle.w12,
                            textAlign: TextAlign.center,
                          ),
                          const Icon(
                            SodaIcons.listeners,
                            size: 15,
                            color: Colors.white,
                          )
                        ]),
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
