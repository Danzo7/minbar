import 'package:flutter/material.dart';
import 'package:minbar_fl/components/static/colors.dart';
import 'package:minbar_fl/components/widgets/NavgationBar/NavigationBar.dart';

class NavigationPainter extends CustomPainter {
  final NavType type;
  final Color color;
  NavigationPainter({required this.type, this.color = Colors.white});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = DColors.blueGray
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(0, 0, 0, 30);
    path.quadraticBezierTo(0, 0, size.width * 0.1, 0);

    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);

    if (type == NavType.listen) {
      path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
      path.arcToPoint(Offset(size.width * 0.60, 10),
          radius: Radius.circular(20.0), clockwise: true);
    }

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
    return false;
  }
}
