import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'dart:math' as math;

class FloatingCircles extends StatefulWidget {
  const FloatingCircles({super.key});

  @override
  State<FloatingCircles> createState() => _FloatingCirclesState();
}

class _FloatingCirclesState extends State<FloatingCircles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<CircleModel> _circles = List.generate(
    15,
    (index) => CircleModel(),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _CirclesPainter(
              circles: _circles,
              progress: _controller.value,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _CirclesPainter extends CustomPainter {
  final List<CircleModel> circles;
  final double progress;

  _CirclesPainter({required this.circles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      final double t = progress;
      final double x =
          circle.baseX + math.sin(t * 2 * math.pi + circle.phase) * 50;
      final double y =
          circle.baseY + math.cos(t * 2 * math.pi + circle.phase) * 50;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.orange.withOpacity(circle.opacity),
            AppColors.orange.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: circle.size / 2));

      canvas.drawCircle(Offset(x, y), circle.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CirclesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class CircleModel {
  late double baseX;
  late double baseY;
  late double size;
  late double opacity;
  late double phase;

  CircleModel() {
    baseX = math.Random().nextDouble() * 2000;
    baseY = math.Random().nextDouble() * 2000;
    size = math.Random().nextDouble() * 300 + 100;
    opacity = math.Random().nextDouble() * 0.1;
    phase = math.Random().nextDouble() * 2 * math.pi;
  }
}
