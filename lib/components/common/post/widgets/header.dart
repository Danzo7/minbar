import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

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
          ClipOval(
            child: Container(
                height: 29,
                width: 30,
                child: Image.asset(
                  pub.authorAvatar,
                  fit: BoxFit.fitWidth,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(pub.authorName, style: DTextStyle.bg12b),
                    if (pub.hasCast)
                      Text(
                        "قام ببث",
                        style: DTextStyle.b10,
                      ),
                    if (pub.hasCast)
                      NotAButton(
                        child: Text(pub.type, style: DTextStyle.w10),
                        backgroundColor: DColors.orange,
                        raduis: 7,
                        spacing: 5,
                      )
                  ]),
              Text(
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
