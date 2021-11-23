import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/minbar_theme.dart';

import 'navigation_painter.dart';

enum AnimationDirection { forward, backward, idle, completed }

class AnimatedPainter extends StatelessWidget {
  final AnimationDirection direction;

  final double max;
  final bool isInside;
  const AnimatedPainter({
    Key? key,
    this.direction = AnimationDirection.idle,
    required this.max,
    this.isInside = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.direction == AnimationDirection.idle
        ? CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: NavigationPainter(pulling: 0))
        : this.direction == AnimationDirection.completed
            ? CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: NavigationPainter(
                    pulling: isInside ? 0 : max, pushing: isInside ? max : 0))
            : TweenAnimationBuilder<double?>(
                tween: this.direction == AnimationDirection.forward
                    ? Tween<double>(begin: 0, end: max)
                    : Tween<double>(begin: max, end: 0),
                curve: Curves.easeInOut,
                duration: kMedAnimationDuration,
                builder: (context, value, child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 80),
                    painter: !isInside
                        ? NavigationPainter(pulling: value ?? 0)
                        : NavigationPainter(pushing: value),
                  );
                },
              );
  }
}
