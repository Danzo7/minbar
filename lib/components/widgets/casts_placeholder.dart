import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_colors.dart';
import 'package:shimmer/shimmer.dart';

class CastPlaceholder extends StatelessWidget {
  const CastPlaceholder({Key? key, this.height = 120}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: DColors.coldGray,
      highlightColor: DColors.coldGray.withOpacity(0.2),
      child: SizedBox(
          width: double.infinity,
          height: height,
          child: Container(
            decoration: BoxDecoration(
                color: DColors.coldGray,
                borderRadius: BorderRadius.circular(17)),
          )),
    );
  }
}
