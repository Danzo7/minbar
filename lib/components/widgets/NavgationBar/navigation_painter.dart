import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/navigation_bar.dart';

class NavigationPainter extends CustomPainter {
  final NavType type;
  final Color color;

  final double pulling;
  const NavigationPainter(
      {required this.type, this.color = Colors.white, this.pulling = 0});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..color = DColors.blueGray
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(0, 0, 0, 30);
    path.quadraticBezierTo(0, 0, size.width * 0.1, 0);

    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);

    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.45, -15);
    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.45, -15);
    // path.arcToPoint(Offset(size.width * 0.55, -15),
    //     radius: Radius.circular(35.0), clockwise: true);
    // path.quadraticBezierTo(size.width * 0.50, -15, size.width * 0.55, -15);

    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.45, -pulling);
    path.quadraticBezierTo(
        size.width * 0.40, -pulling, size.width * 0.45, -pulling);
    path.arcToPoint(Offset(size.width * 0.55, -pulling),
        radius: Radius.circular((pulling < 7 ? (0) : 30)), clockwise: true);
    path.quadraticBezierTo(
        size.width * 0.50, -pulling, size.width * 0.55, -pulling);

    if (type == NavType.broadcastable) {
      path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
      path.arcToPoint(Offset(size.width * 0.60, 20),
          radius: Radius.circular(20.0), clockwise: false);
    }
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);

    path.quadraticBezierTo(size.width * 0.90, 0, size.width * 0.90, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
