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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: _circles.map((circle) {
            final double t = _controller.value;
            final double x =
                circle.baseX + math.sin(t * 2 * math.pi + circle.phase) * 50;
            final double y =
                circle.baseY + math.cos(t * 2 * math.pi + circle.phase) * 50;

            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: circle.size,
                height: circle.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.orange.withOpacity(circle.opacity),
                      AppColors.orange.withOpacity(0),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CircleModel {
  late double baseX;
  late double baseY;
  late double size;
  late double opacity;
  late double phase;

  CircleModel() {
    baseX = math.Random().nextDouble() * 1500;
    baseY = math.Random().nextDouble() * 1000;
    size = math.Random().nextDouble() * 300 + 100;
    opacity = math.Random().nextDouble() * 0.1;
    phase = math.Random().nextDouble() * 2 * math.pi;
  }
}
