import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/static/textStyles.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class Header extends StatelessWidget {
  final String username;
  final bool withDetail;
//
  final String timeAgo;
  final String? field, verb;
  final String avatarPath;
  const Header(
      {Key? key,
      required this.username,
      required this.avatarPath,
      this.withDetail = false,
      this.field,
      this.verb,
      required this.timeAgo})
      : super(key: key);
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
                  avatarPath,
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
                    Text(username, style: DTextStyle.bg12b),
                    if (withDetail)
                      Text(
                        verb ?? "",
                        style: DTextStyle.b10,
                      ),
                    if (withDetail)
                      NotAButton(
                        child: Text(field ?? "", style: DTextStyle.w10),
                        backgroundColor: DColors.orange,
                        raduis: 7,
                        spacing: 5,
                      )
                  ]),
              Text(
                timeAgo,
                style: DTextStyle.bg10,
              )
            ],
          )
        ],
      ),
    );
  }
}
