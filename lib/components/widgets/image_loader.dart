import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.placeholder = false,
    this.raduis,
  });
  final double? raduis;
  final bool placeholder;
  final BoxFit? fit;
  final double? height;
  final String? imageUrl;
  final double? width;

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: DColors.coldGray,
        child: FractionallySizedBox(
          widthFactor: .5,
          heightFactor: .5,
          child: FittedBox(
            child: Icon(
              Icons.broken_image_rounded,
              color: DColors.blueGray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    return AnimatedSwitcher(
      duration: kFastAnimationDuration,
      child: loadingProgress == null
          ? child
          : Shimmer.fromColors(
              baseColor: DColors.coldGray,
              highlightColor: DColors.white,
              child: Container(
                color: DColors.blueSaidGray,
                height: raduis ?? height,
                width: raduis ?? width,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return placeholder && imageUrl == null
        ? Image.asset(
            "assets/images/profilePicture.png",
            fit: BoxFit.fitWidth,
          )
        : Image.network(
            imageUrl ?? '',
            errorBuilder: _errorBuilder,
            loadingBuilder: _loadingBuilder,
            fit: fit,
            width: width,
            height: height,
          );
  }
}
