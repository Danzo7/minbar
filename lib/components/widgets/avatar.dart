import 'package:flutter/material.dart';

import 'image_loader.dart';

class Avatar extends StatelessWidget {
  final double raduis;

  ///enable this only for teting. will use a default image(صورة مسيلمة الكذاب) from assets for avatar
  final bool withPlaceholder;
  final Color? borderColor;
  final Object? heroTag;
  const Avatar(this.imageUrl,
      {Key? key,
      required this.raduis,
      this.withPlaceholder = false,
      this.heroTag,
      this.borderColor})
      : super(key: key);
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    Widget image = ImageLoader(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: withPlaceholder,
    );

    if (heroTag != null) {
      image = Hero(
        tag: heroTag!,
        child: image,
      );
    }
    return createBorderCircleAvatar(child: image, borderColor: borderColor);
  }

  Widget createBorderCircleAvatar({Color? borderColor, required Widget child}) {
    if (borderColor == null)
      return CircleAvatar(
        radius: raduis,
        child: SizedBox.expand(
          child: ClipOval(
            child: child,
          ),
        ),
      );
    else
      return CircleAvatar(
        radius: raduis,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: raduis - 1,
          child: SizedBox.expand(
            child: ClipOval(
              child: child,
            ),
          ),
        ),
      );
  }
}
