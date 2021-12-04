import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:shimmer/shimmer.dart';

class PostPlaceholder extends StatelessWidget {
  const PostPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget placeHolder({double? height, double? width, double? radius}) =>
        Shimmer.fromColors(
          baseColor: DColors.coldGray,
          highlightColor: DColors.coldGray.withOpacity(0.2),
          child: SizedBox(
              height: height,
              width: width,
              child: Container(
                decoration: BoxDecoration(
                    color: DColors.coldGray,
                    borderRadius: BorderRadius.circular(20)),
              )),
        );
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: DColors.coldGray)),
        child: Wrap(runSpacing: 10, children: [
          Container(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                placeHolder(height: 30, width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          placeHolder(
                            height: 12,
                            width: 85,
                          ),
                        ]),
                    SizedBox(height: 5),
                    placeHolder(height: 12, width: 29)
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    placeHolder(height: 14, width: 49),
                    SizedBox(width: 5),
                    placeHolder(height: 14, width: 100),
                    SizedBox(width: 5),
                    Expanded(child: placeHolder(height: 14))
                  ],
                ),
                SizedBox(height: 5),
                placeHolder(height: 14, width: double.infinity),
                SizedBox(height: 10),
                placeHolder(height: 80, width: double.infinity),
              ],
            ),
          )
        ]));
  }
}
