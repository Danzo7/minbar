import 'package:flutter/material.dart';
import 'package:minbar_fl/components/screens/settings/setting_params_screen.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

import '../setting_data_presentation.dart';

class TreeLeaf extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onPressed;
  const TreeLeaf({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: MaterialButton(
        onPressed: onPressed,
        child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Icon(
                  icon,
                  color: DColors.blueGray,
                  size: 20,
                )),
                Expanded(
                    flex: 7,
                    child: Text(
                      text,
                      style: DTextStyle.bg12s,
                      textAlign: TextAlign.start,
                    )),
                Flexible(
                    child: Icon(
                  SodaIcons.arrowLeft,
                  color: DColors.blueGray,
                ))
              ]),
        ),
      ),
    );
  }
}

// MaterialButton(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(raduis),
//               side: borderColor != null
//                   ? BorderSide(color: borderColor ?? DColors.white)
//                   : BorderSide.none),
//           constraints: BoxConstraints(),
//           fillColor: backgroundColor,
//           elevation: 0,
//           hoverElevation: 0,
//           highlightElevation: 0,
//           onPressed: onTap,
//           padding: EdgeInsets.symmetric(horizontal: spacing),
//           child: UnconstrainedBox(
//             child: Container(
//               height: height,
//               width: width,
//               alignment: Alignment.center,
//               child: child,
//             ),
//           ),
//         ),
   