import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

class ReactionBar extends StatelessWidget {
  const ReactionBar(
      {Key? key,
      required this.heartCount,
      required this.pinCount,
      this.hasHeart = false,
      this.hasPin = false})
      : super(key: key);

  final bool hasHeart, hasPin;
  final int heartCount, pinCount;
  void updateHeart(bool isClicked) {
    if (isClicked) {
//update the counter by 1
    } else {
//update the counter by -1
    }
  }

  Future<bool?> updatePin(bool isClicked) async {
    if (isClicked) {
//update the counter by 1
    } else {
//update the counter by -1
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            spacing: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [pinButton(), heartButton()]));
  }

  ReactButton heartButton() {
    return ReactButton(heartCount,
        isPressed: hasHeart,
        beforeIcon: SodaIcons.heart_outlined,
        afterIcon: SodaIcons.heart);
  }

  ReactButton pinButton() => ReactButton(pinCount,
      isPressed: hasPin,
      beforeIcon: SodaIcons.pin_outlined,
      afterIcon: SodaIcons.pin);
}

class ReactButton extends StatelessWidget {
  final Future<bool?> Function(bool)? update;
  final bool? isPressed;
  final int count;
  final IconData beforeIcon, afterIcon;
  const ReactButton(this.count,
      {Key? key,
      this.update,
      this.isPressed,
      required this.beforeIcon,
      required this.afterIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: DColors.coldGray)),
        child: LikeButton(
          isLiked: isPressed,
          onTap: update,
          circleColor: CircleColor(start: DColors.sadRed, end: DColors.orange),
          bubblesColor: BubblesColor(
            dotPrimaryColor: DColors.sailBlue,
            dotSecondaryColor: DColors.sadRed,
          ),
          likeBuilder: (bool isPressed) {
            return isPressed
                ? Icon(afterIcon, color: DColors.sadRed, size: 14)
                : Icon(beforeIcon, color: DColors.sadRed, size: 14);
          },
          likeCount: count,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? DColors.sadRed : DColors.grayBrown;
            return Text(
              text,
              style: TextStyle(color: color),
            );
          },
        ),
      ),
    );
  }
}
/**
   LikeButton(
          size: buttonSize,
          circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.home,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: buttonSize,
            );
          },
          likeCount: 665,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),
 */
