import 'package:flutter/material.dart';
import 'package:minbar_fl/components/widgets/image_loader.dart';

class Avatar extends StatelessWidget {
  final double raduis;

  ///enable this only for teting. will use a default image(صورة مسيلمة الكذاب) from assets for avatar
  final bool withPlaceholder;
  final Color? borderColor;
  final int borderWidth;
  final Object? heroTag;
  const Avatar(this.imageUrl,
      {Key? key,
      required this.raduis,
      this.withPlaceholder = false,
      this.heroTag,
      this.borderColor,
      this.borderWidth = 1})
      : super(key: key);
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    Widget image = ImageLoader(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: withPlaceholder,
        raduis: raduis);

    if (heroTag != null) {
      image = Hero(
        tag: heroTag!,
        child: image,
      );
    }
    return createBorderCircleAvatar(child: image, borderColor: borderColor);
  }

  Widget createBorderCircleAvatar({Color? borderColor, required Widget child}) {
    if (borderColor == null) {
      return CircleAvatar(
        radius: raduis,
        child: SizedBox.expand(
          child: ClipOval(
            child: child,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        radius: raduis,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: raduis - borderWidth,
          child: SizedBox.expand(
            child: ClipOval(
              child: child,
            ),
          ),
        ),
      );
    }
  }
}
