import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/model/cast.dart';

class PodcastBox extends StatelessWidget {
  final Cast cast;
  const PodcastBox({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/cover.png'),
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
                  if (!cast.isLive)
                    Container(
                        alignment: Alignment.topRight,
                        child: Wrap(
                            spacing: 3,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            verticalDirection: VerticalDirection.up,
                            children: [
                              Text(
                                cast.duration!,
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
                            cast.listeners.toString(),
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
