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
    final path = _getStarPath(size, 5);
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path _getStarPath(Size size, verticies) {
    final double outerRadius = size.width * .5;
    final double innerRadius = outerRadius * .4;
    final centerX = size.width * .5;
    final centerY = size.height * .5;

    var rotation = math.pi * .5 * 3;
    final double step = math.pi / verticies;

    final path = Path();
    path.moveTo(centerX, centerY - outerRadius);
    for (var i = 0; i < verticies; i += 1) {
      final double outerX = centerX + math.cos(rotation) * outerRadius;
      final double outerY = centerY + math.sin(rotation) * outerRadius;
      path.lineTo(outerX, outerY);
      rotation += step;

      final double innerX = centerX + math.cos(rotation) * innerRadius;
      final double innerY = centerY + math.sin(rotation) * innerRadius;
      path.lineTo(innerX, innerY);
      rotation += step;
    }
    path.lineTo(centerX, centerY - outerRadius);
    path.close();

    return path;
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final double size;
  final Color color;

  const StarRating(
      {super.key,
      required this.value,
      this.size = 25,
      this.color = Colors.deepOrange});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
            value,
            (_) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Star(
                  color: color,
                  size: size,
                ))));
  }
}
