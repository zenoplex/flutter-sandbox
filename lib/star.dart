import 'package:flutter/material.dart';
import 'dart:math' as math;

class Star extends StatelessWidget {
  final Color color;
  final double size;

  const Star({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _StarPainter(color: color)));
  }
}

class _StarPainter extends CustomPainter {
  final Color color;

  const _StarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const int vertex = 5;
    final double outerRadius = size.width * .5;
    final double innerRadius = outerRadius * .5;
    const angle = (math.pi * 2) / vertex;
    const halfAngle = angle * .5;
    final centerX = size.width * .5;
    final centerY = size.height * .5;

    // TODO: fix the star shape
    final path = Path();
    for (var i = 0; i < vertex; i += 1) {
      final double a = i * angle;
      final double outerX = centerX + math.cos(a) * outerRadius;
      final double outerY = centerY + math.sin(a) * outerRadius;

      final double innerX = centerX + math.cos(a + halfAngle) * innerRadius;
      final double innerY = centerY + math.sin(a + halfAngle) * innerRadius;

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
        path.lineTo(innerX, innerY);
      }
    }
    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final double size;

  const StarRating({super.key, required this.value, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
            value,
            (_) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Star(
                  color: Colors.black,
                  size: size,
                ))));
  }
}
