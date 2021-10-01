import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/soda_icons_icons.dart';
import 'package:minbar_fl/components/static/default_colors.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';

class ReactionBar extends StatefulWidget {
  final int likeAmount, pinsAmount;
  ReactionBar({Key? key, required this.likeAmount, required this.pinsAmount})
      : super(key: key);

  @override
  _ReactionBarState createState() => _ReactionBarState();
}

class _ReactionBarState extends State<ReactionBar> {
  bool _likeIsDown = false;
  bool _pinIsDown = false;

  _updateLikeBtnState() {
    setState(() {
      _likeIsDown = !_likeIsDown;
    });
  }

  _updatepinBtnState() {
    setState(() {
      _pinIsDown = !_pinIsDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            spacing: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
          ContentButtonV2(
            borderColor: DColors.coldGray,
            raduis: 7,
            spacing: 10,
            height: 30,
            onTap: () => {_updatepinBtnState()()},
            child: Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  (widget.pinsAmount + (_pinIsDown ? 1 : 0)).toString(),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(color: DColors.sadRed, fontSize: 13),
                ),
                _pinIsDown
                    ? Icon(SodaIcons.pin, color: DColors.sadRed, size: 14)
                    : Icon(SodaIcons.pin_outlined,
                        color: DColors.sadRed, size: 14)
              ],
            ),
          ),
          ContentButtonV2(
            borderColor: DColors.coldGray,
            raduis: 7,
            height: 30,
            spacing: 10,
            onTap: () => {_updateLikeBtnState()},
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                Text(
                  (widget.likeAmount + (_likeIsDown ? 1 : 0)).toString(),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(color: DColors.sadRed, fontSize: 13),
                ),
                _likeIsDown
                    ? Icon(SodaIcons.heart, color: DColors.sadRed, size: 14)
                    : Icon(SodaIcons.heart_outlined,
                        color: DColors.sadRed, size: 14)
              ],
            ),
          )
        ]));
  }
}
