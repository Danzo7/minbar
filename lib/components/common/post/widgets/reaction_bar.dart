import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:minbar_fl/components/common/timelines/posts_timeline/bloc/posts_bloc.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/buttons/buttons.dart';
import 'package:minbar_fl/model/publication.dart';
import 'package:provider/provider.dart';

class ReactionBar extends StatelessWidget {
  const ReactionBar({Key? key, required this.pub}) : super(key: key);
  final Publication pub;
  Future<bool?> updateHeart(bool isClicked) async {
    return !isClicked;
  }

  Future<bool?> updatePin(bool isClicked) async {
    //  pub.hasHeart = isClicked;

    return !isClicked;
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> values = [pub.hasHeart, pub.hasPin];

    ReactButton heartButton(Future<bool?> Function(bool)? update) {
      return ReactButton(
        pub.heartCount,
        isPressed: pub.hasHeart,
        beforeIcon: SodaIcons.heart_outlined,
        afterIcon: SodaIcons.heart,
        update: (clicked) async {
          await context
              .read<PostsBloc>()
              .repo
              .updatePublication(pub, liked: !clicked, pinned: values[1]);
          values[0] = !clicked;

          return !clicked;
        },
      );
    }

    ReactButton pinButton(Future<bool?> Function(bool)? update) =>
        ReactButton(pub.pinCount,
            isPressed: pub.hasPin,
            beforeIcon: SodaIcons.pin_outlined,
            afterIcon: SodaIcons.pin, update: (clicked) async {
          await context
              .read<PostsBloc>()
              .repo
              .updatePublication(pub, pinned: !clicked, liked: values[0]);
          values[1] = !clicked;

          return !clicked;
        });

    return Container(
        child: Wrap(
            spacing: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [pinButton(updatePin), heartButton(updateHeart)]));
  }
}

///

class ReactButton extends StatelessWidget {
  final Future<bool?> Function(bool)? update;
  final bool? isPressed;
  final int count;
  final IconData beforeIcon, afterIcon;
  ReactButton(
    this.count, {
    Key? key,
    this.update,
    this.isPressed,
    required this.beforeIcon,
    required this.afterIcon,
  }) : super(key: key);
  final TapController tc = TapController();
  @override
  Widget build(BuildContext context) {
    return ContentButtonV2(
      borderColor: DColors.coldGray,
      raduis: 7,
      spacing: 0,
      onTap: tc.tap,
      child: LikeButton(
        controller: tc,
        internalTap: false,
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
          return Text(
            text,
            style:
                TextStyle(color: isLiked ? DColors.sadRed : DColors.grayBrown),
          );
        },
      ),
    );
  }
}
