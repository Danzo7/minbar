import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/Icons.dart';
import 'package:minbar_fl/components/static/colors.dart';
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
          ContentButton(
            borderColor: DColors.coldGray,
            raduis: 7,
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
                IconBuilder(
                  "pin",
                  color: DColors.sadRed,
                  size: 14,
                  fill: _pinIsDown,
                )
              ],
            ),
          ),
          ContentButtonV2(
            borderColor: DColors.coldGray,
            raduis: 7,
            height: 30,
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
                IconBuilder(
                  "heart",
                  color: DColors.sadRed,
                  size: 14,
                  fill: _likeIsDown,
                )
              ],
            ),
          )
        ]));
  }
}
