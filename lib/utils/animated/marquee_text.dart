import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MarqueeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double velocity;

  const MarqueeText({
    super.key,
    required this.text,
    required this.style,
    this.velocity = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final String repeatedText = "$text - $text - $text - $text - ";

    return RepaintBoundary(
      child: Stack(
        children: [
          Animate(
            onPlay: (controller) => controller.repeat(),
            effects: [
              MoveEffect(
                begin: const Offset(0, 0),
                end: const Offset(-500, 0),
                duration: const Duration(seconds: 10),
                curve: Curves.linear,
              ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                10,
                (index) => Text(repeatedText, style: style),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
