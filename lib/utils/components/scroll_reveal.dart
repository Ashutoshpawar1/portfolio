import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;
  final Curve curve;
  final double visibleFraction;

  const ScrollReveal({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 0.04),
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
    this.visibleFraction = 0.02,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  late final Key _visibilityKey = ValueKey(
    'scroll-reveal-${identityHashCode(this)}',
  );
  bool _isVisible = false;

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (_isVisible || !mounted) {
      return;
    }

    if (info.visibleFraction >= widget.visibleFraction) {
      setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _handleVisibilityChanged,
      child: widget.child
          .animate(target: _isVisible ? 1.0 : 0.0)
          .fadeIn(duration: widget.duration, curve: widget.curve)
          .slide(
            begin: widget.beginOffset,
            end: Offset.zero,
            duration: widget.duration,
            curve: widget.curve,
          ),
    );
  }
}
