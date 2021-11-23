import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/avatar.dart';

import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/model/publication.dart';

class Header extends StatelessWidget {
  final Publication pub;
  const Header(this.pub, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Avatar(
            pub.author.avatarUrl,
            raduis: 15,
            withPlaceholder: true,
            borderWidth: 2,
            borderColor:
                pub.hasCast && pub.cast!.isLive ? DColors.sadRed : null,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(pub.author.fullName, style: DTextStyle.bg12b),
                    if (pub.hasCast)
                      Text(
                        "قام ببث",
                        style: DTextStyle.b10,
                      ),
                    if (pub.hasCast)
                      NotAButton(
                        child: Text(pub.cast!.field, style: DTextStyle.w10),
                        backgroundColor: DColors.orange,
                        raduis: 7,
                        spacing: 5,
                      )
                  ]),
              pub.hasCast && pub.cast!.isLive
                  ? Text(
                      "مباشر",
                      style: DTextStyle.w10b.copyWith(color: DColors.sadRed),
                    )
                  : Text(
                      pub.timestamp,
                      style: DTextStyle.bg10,
                    )
            ],
          )
        ],
      ),
    );
  }
}
